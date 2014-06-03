    require 'rubygems'
    require 'rtf'

    include RTF

class SubscriptionFormsController < ApplicationController

  def index
    @firm = Firm.find(params[:id])
    @round = Round.find(params[:round_id])
  end

  def show
    @firm = Firm.find(params[:id])
    @round = Round.find(params[:round_id])
    @investment = Investment.find(params[:investment_id])
    @shareholder = Shareholder.find(params[:shareholder_id])

    generate_subscription_form

    redirect_to subscription_forms_path(@firm, @round)

  end

  def generate_subscription_form


    styles = {}
    styles['HEADER'] = CharacterStyle.new
    styles['HEADER'].bold      = true
    styles['HEADER'].font_size = 30
    styles['HEADER-CENTER'] = ParagraphStyle.new
    styles['HEADER-CENTER'].justification = ParagraphStyle::CENTER_JUSTIFY
    styles['NORMAL'] = ParagraphStyle.new
    styles['NORMAL'].justification = ParagraphStyle::FULL_JUSTIFY
    styles['TITLES'] = CharacterStyle.new
    styles['TITLES'].bold      = true
    styles['TITLES'].underline = true

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

       ## il me faut :
       #   - new shares (rounds)
    end

    File.open('subscription_form.rtf', 'w') {|file| file.write(form.to_rtf)}
  end

end
