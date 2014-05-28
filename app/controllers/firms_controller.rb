class FirmsController < ApplicationController

  before_action :find_firm, only: [:show, :edit, :update, :destroy, :shareholders, :create_shareholder, :ownership, :udpate_ownership, :refresh_financial_infos]
  before_action :authenticate_user!
  respond_to :js, :html

  def index
    @firms = Firm.all
  end

  def show
    authorize @firm
    @shareholders = @firm.shareholders
    @shares = @shareholders.sum("shares")
  end

  def new
    @firm = Firm.new
  end

  def create
    @firm = Firm.new(firm_params)
    if @firm.valid?
      @firm.save
      redirect_to add_shareholders_path(@firm)
    else
     flash[:error] = @firm.errors.full_messages
     render :new
   end
  end

  def edit
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
    params[:shareholder].keys.each do |id|
      @shareholder = Shareholder.find(id.to_i)
      @shareholder.update_attributes(set_shares(id))
    end
    refresh_financial_infos
    redirect_to firm_path
  end

  def refresh_financial_infos
    @firm = Firm.find(params[:id])
    @firm.update_attribute(:shares, @firm.shareholders.sum("shares"))
    @firm.update_attribute(:nominal_value, @firm.initial_capital/@firm.shares)
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

    def set_shares(id)
      params.require(:shareholder).fetch(id).permit(:shares)
    end

end
