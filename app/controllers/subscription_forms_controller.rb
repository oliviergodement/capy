require 'rubygems'
require 'rtf'
require 'zip'

include RTF

class SubscriptionFormsController < ApplicationController

  before_action :authenticate_user!

  def index
    @firm = Firm.find(params[:id])
    authorize @firm
    @round = Round.find(params[:round_id])
  end

  def show
    @firm = Firm.find(params[:id])
    authorize @firm
    @round = Round.find(params[:round_id])
    @investment = Investment.find(params[:investment_id])
    @shareholder = Shareholder.find(params[:shareholder_id])

    file_name = "bon_souscription_#{@firm.name.gsub(/\s+/, "")}_#{@shareholder.last_name}.doc"
    send_data generate_subscription_form(@shareholder), filename: file_name
  end

  def zip_form
    @firm = Firm.find(params[:id])
    authorize @firm
    @round = Round.find(params[:round_id])

    zipfile_name = "bulletins_#{@firm.name.gsub(/\s+/, "").downcase}.zip"

    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      i = 1
      @round.shareholders.each do |shareholder|
        file_name = "bon_#{@firm.name.gsub(/\s+/, "")}_#{shareholder.last_name}_#{i}.doc"
        File.open(file_name, 'w') do |file|
          file.write(generate_subscription_form(shareholder))
        end
        zipfile.add(file_name, file_name)
        i += 1
      end
      send_data zipfile_name, filename: zipfile_name
      # TODO
      # - sends empty zip file
      # - doesnt delete temp files
    end
  end

  def generate_subscription_form(shareholder)
    styles = {}
    styles['HEADER'] = CharacterStyle.new
    styles['HEADER'].bold      = true
    styles['HEADER'].font_size = 30
    styles['HEADER-CENTER'] = ParagraphStyle.new
    styles['HEADER-CENTER'].justification = ParagraphStyle::CENTER_JUSTIFY
    styles['NORMAL'] = ParagraphStyle.new
    styles['NORMAL'].justification = ParagraphStyle::FULL_JUSTIFY
    # pas encore utilisé
    styles['NORMAL_SIZE'] = CharacterStyle.new
    styles['NORMAL_SIZE'].font_size = 20
    styles['TITLES'] = CharacterStyle.new
    styles['TITLES'].bold      = true
    styles['TITLES'].underline = true
    styles['INDENTED'] = ParagraphStyle.new
    styles['INDENTED'].left_indent = 400

    form = Document.new(Font.new(Font::ROMAN, 'Times New Roman'))

    form.paragraph(styles['HEADER-CENTER']) do |p|
       p.apply(styles['HEADER']) do |s|
          s << @firm.name.upcase
          s.line_break
          s << "Société par actions simplifiée au capital de #{@firm.initial_capital.round(2)} euros"
          s.line_break
          s << "siège social : #{@firm.official_address}"
          s.line_break
          s << "#{@firm.rcs} R.C.S. #{@firm.court_service}"
          s.line_break
          s << "la 'Société'"
          s.line_break
          s << "BULLETIN DE SOUSCRIPTION"
          s.line_break
          s << "En date du #{Date.today}"
          s.line_break
          s.line_break
          s.line_break
       end
    end

    form.paragraph(styles['NORMAL']) do |p|
      p.apply(styles['TITLES']) do |s|
        s << "1.  Montant et modalités de l’augmentation de capital"
        s.line_break
        s.line_break
      end
       p << "Aux termes d’une décision collective des Associés de la Société en date du  DATE, il a été décidé d’augmenter le capital "
       p << "social de #{@round.real_amount_raised} euros pour le porter de "
       p << "#{@firm.initial_capital} euros à #{@firm.initial_capital + @round.real_amount_raised} euros "
       p << "par l'émission de #{@firm.shareholders.sum('corrected_shares')} actions ordinaires nouvelles de "
       p << "la Société de #{@firm.nominal_value.round(2)} € de valeur nominale chacune"

       p << "Il a également été décidé, conformément aux dispositions des articles L. 225-135 et L. 225-138 du Code de commerce, de supprimer le droit préférentiel de souscription des Associés pour la totalité de l’augmentation de capital social, et ainsi d’en réserver la souscription aux personnes nommément désignées suivantes :"
       p.line_break
    end

    form.paragraph(styles['INDENTED']) do |p|
      @firm.shareholders.where(initial_investor: false).each do |investor|
        p << "- à hauteur de #{investor.investments.last.real_amount} €, soit #{investor.corrected_shares} actions ordinaires nouvelles de la Société, à #{investor.first_name} #{investor.last_name}, né(e) le #{investor.birth_date}, de nationalité #{investor.nationality} et résidant à #{investor.address}"
        p.line_break
        p.line_break
      end
    end

    form.paragraph(styles['NORMAL']) do |p|
      p << "Les actions ordinaires nouvelles sont émises au prix unitaire d’environ #{@firm.real_value.round(2)} €, soit avec une prime d’émission d’environ #{@firm.premium.round(2)} €."
      p.line_break
      p.line_break
      p << "Les actions ordinaires nouvelles doivent être libérées en totalité lors de la souscription par versement en numéraire."
      p.line_break
      p.line_break
      p << "Les actions ordinaires nouvelles porteront jouissance à compter de leur émission et seront dès leur création assimilées aux actions ordinaires anciennes, et soumises à toutes les dispositions des statuts et aux décisions collectives des Associés."
      p.line_break
      p.line_break
      p << "Les actions ordinaires nouvelles seront inscrites en compte le jour de la réalisation de l’augmentation de capital et négociables à compter du même jour dans les conditions prévues par les statuts de la Société."
      p.line_break
      p.line_break
      p << "Les bulletins de souscription et versements seront reçus au siège social à compter de la décision des Associés de la Société et jusqu’au 15 juin 2014 inclus [Au moins 5 jours de bourse à dater de l'ouverture de la souscription – L. 225-141 du Code de commerce], au plus tard. Le délai de souscription se trouvera clos par anticipation dès que l’augmentation aura été intégralement souscrite et les actions libérées de la totalité du prix d’émission."
      p.line_break
      p.line_break
    end

    form.paragraph(styles['NORMAL']) do |p|
      p.apply(styles['TITLES']) do |s|
        s << "2.  Versement des fonds"
        s.line_break
        s.line_break
      end
       p << "Les fonds correspondant à la libération de la souscription seront versés sur le compte bancaire "
       p << "n° #{@firm.bank_account} ouvert au nom de la Société auprès de l’agence bancaire #{@firm.bank_agency} de la #{@firm.bank_name} sise #{@firm.bank_agency_address}, qui établira le certificat du dépositaire. Les fonds y seront conservés jusqu’à la réalisation définitive de l’augmentation de capital."
    end

    form.paragraph(styles['NORMAL']) do |p|
      p.apply(styles['TITLES']) do |s|
        s << "3.  Souscription"
        s.line_break
        s.line_break
      end
       p << "Je, soussigné[e] ;"
       p.line_break
       p.line_break
       p << "#{shareholder.first_name} #{shareholder.last_name}, né[e] le #{shareholder.birth_date} à REMPLIR, et résidant à #{shareholder.address} ;"
       p.line_break
       p.line_break
       p << "bénéficiaire, à la suite de la suppression à son profit du droit préférentiel de souscription des Associés, du droit à la souscription de #{shareholder.corrected_shares} actions ordinaires nouvelles de la Société ;"
       p.line_break
       p.line_break
       p << "après avoir pris connaissance des statuts de la Société, des conditions et des modalités de l’émission de #{@round.shares_issued} actions ordinaires nouvelles composant l’intégralité de l’augmentation de capital en numéraire sus-énoncée ;"
       p.line_break
       p.line_break
       p << "déclare"
       p.line_break
       p.line_break
       p.line_break
       p.line_break
    end

    form.paragraph(styles['INDENTED']) do |p|
      p << "− souscrire à #{shareholder.corrected_shares} actions ordinaires nouvelles de la Société de #{@firm.nominal_value.round(2)} € de valeur nominale chacune, soit la totalité de la quote-part m’étant réservée, émises au prix de souscription d’environ #{@firm.real_value.round(2)} € chacune (prime d’émission incluse), soit un prix total de #{(shareholder.corrected_shares * @firm.real_value).round(2)} € ;"
      p.line_break
      p.line_break
      p << "− s’engager à libérer en numéraire lors de la souscription le montant correspondant à l’intégralité des actions souscrites, soit la somme de #{(shareholder.corrected_shares * @firm.real_value).round(2)} € ;"
      p.line_break
      p.line_break
    end

    form.paragraph(styles['NORMAL']) do |p|
      p << "Je reconnais que la présente souscription a un caractère purement privé et a lieu sans offre au public."
      p.line_break
      p << "Je déclare qu’un exemplaire sur papier libre du présent bulletin de souscription m’a été remis."
      p.line_break
      p.line_break
      p.line_break
      p.line_break
      p << "Fait à _________________________, le _______________________ 2014"
      p.line_break
      p.line_break
      p << "En deux (2) exemplaires originaux dont un est resté en ma possession,"
      p.line_break
      p.line_break
      p.line_break
      p.line_break
      p.line_break
      p.line_break
      p << "Veuillez faire précéder votre signature de la mention manuscrite suivante :"
      p.line_break
      p << "« Bon pour souscription à #{shareholder.corrected_shares} actions ordinaires nouvelles de la Société de #{@firm.nominal_value.round(2)} € de valeur nominale chacune »"
    end

    form.to_rtf
  end

end
