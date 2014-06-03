class FirmsController < ApplicationController

  before_action :find_firm, only: [:show, :edit, :update, :destroy, :cap_table, :shareholders, :create_shareholder, :ownership, :update_ownership, :refresh_financial_infos]
  before_action :find_round, only: [:ownership, :update_ownership]
  before_action :authenticate_user!
  respond_to :js, :html

  def index
    @firms = Firm.all
  end

  def show
    authorize @firm
    @shareholders = @firm.shareholders
    if @firm.rounds == 1
      @shares = @shareholders.sum("shares")
    end
  end

  def cap_table
    respond_to do |format|
      format.xls
      format.html
    end
  end

  def new
    @firm = Firm.new
  end

  def create
    @firm = Firm.new(firm_params)
    if @firm.valid?
      @firm.save
      @round = Round.create(firm_id: @firm.id, name: "Situation initiale pré-levée")
      @round.update_attribute(:initial_round, true)
      redirect_to new_shareholder_path(@firm.id, @round.id)
    else
     flash[:error] = @firm.errors.full_messages
     render :new
   end
  end

  def edit
    @round = @firm.rounds.last if @firm.shareholders.any?
  end

  def update
    authorize @firm
    @firm.update(firm_params)
    redirect_to add_shareholders_path(@firm)
  end

  def destroy
    authorize @firm
    @firm.destroy
    redirect_to firms_path
  end

  def ownership
    authorize @firm
    @shareholders = @firm.shareholders
  end

  def update_ownership
    # for initial investors
    if @round.initial_round
      params[:shareholder].keys.each do |id|
        @shareholder = Shareholder.find(id.to_i)
        @shareholder.update_attributes(set_shares(id))
        @shareholder.update_attribute(:corrected_shares, @shareholder.shares.floor)
      end
      setup_financial_infos(@firm)

      @firm.shareholders.each do |shareholder|
        if shareholder.initial_investor
          Investment.create(firm_id: @firm.id, round_id: @round.id, shareholder_id: shareholder.id, amount: (shareholder.shares * @firm.nominal_value))
        end
      end

    # for new investors
    else
      params[:shareholder].each do |shareholder_id, investment|
        next if investment["amount"].blank?
        @shareholder = Shareholder.find(shareholder_id)
        @shareholder.investments.create(investment.delete_if { |k, v| !%w(amount round_id firm_id).include? k })
      end
      compute_new_value(@firm, @round)
      compute_new_shares(@firm, @round)
    end

    redirect_to firm_path
  end

  def setup_financial_infos(firm)
    firm.update_attribute(:shares, firm.shareholders.sum("shares"))
    firm.update_attribute(:nominal_value, firm.initial_capital/firm.shares)
  end

  def compute_new_value(firm, round)
    round.update_attribute(:amount_raised, round.investments.sum("amount"))
    firm.update_attribute(:pre_valuation, (round.amount_raised/(round.ownership_offered/100) - round.amount_raised))
    firm.update_attribute(:real_value, firm.pre_valuation/firm.shares)
    firm.update_attribute(:premium, firm.real_value - firm.nominal_value)
    firm.update_attribute(:post_valuation, firm.pre_valuation + round.amount_raised)
  end

  def compute_new_shares(firm, round)
    new_outstanding_shares = firm.shares
    round.shareholders.each do |shareholder|
      shareholder.update_attribute(:shares, shareholder.investments.last.amount / firm.real_value)
      shareholder.update_attribute(:corrected_shares, shareholder.shares.floor)
      shareholder.update_attribute(:non_subscribed_amount, (shareholder.shares - shareholder.corrected_shares)*firm.real_value)
      Investment.where(round_id: round.id).where(shareholder_id: shareholder.id).last.update_attribute(:real_amount, (shareholder.corrected_shares * @firm.real_value).round(2))
      new_outstanding_shares += shareholder.corrected_shares
    end

    firm.update_attribute(:shares, new_outstanding_shares)
    round.update_attribute(:real_amount_raised, (firm.shareholders.where(initial_investor: false).sum('corrected_shares') * @firm.real_value).round(2))
    round.update_attribute(:shares_issued, @firm.shareholders.where(initial_investor: false).sum('corrected_shares'))
  end

  private

    def firm_params
      params.require(:firm).permit(:name, :official_address, :rcs, :court_service,
             :bank_name, :bank_agency, :bank_agency_address, :bank_account, :valuation,
             :share_price, :initial_capital, :shares, :user_id)
    end

    def find_firm
      @firm = Firm.find(params[:id])
    end

    def find_round
      @round = Round.find(params[:round_id])
    end

    def investment_params
      params.require(:shareholder).fetch(id).permit(investment_attributes: [:round_id, :firm_id, :amount])
    end

    def set_shares(id)
      params.require(:shareholder).fetch(id).permit(:shares)
    end

end
