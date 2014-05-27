class FirmsController < ApplicationController

  before_action :find_firm, only: [:show, :edit, :update, :destroy, :shareholders, :create_shareholder, :ownership, :udpate_ownership]
  respond_to :js, :html

  def index
    @firms = Firm.all
  end

  def show
    @shareholders = @firm.shareholders
  end

  def new
    @firm = Firm.new
  end

  def create
    @firm = Firm.new(firm_params)
    @firm.save
    redirect_to add_shareholders_path(@firm)
  end

  def edit
  end

  def update
    @firm.update(firm_params)
    redirect_to add_shareholders_path(@firm)
  end

  def destroy
    @firm.destroy
    redirect_to firms_path
  end

  def ownership
    @shareholders = @firm.shareholders
  end

  def update_ownership
    params[:shareholder].keys.each do |id|
      @shareholder = Shareholder.find(id.to_i)
      @shareholder.update_attributes(set_shares(id))
    end
    redirect_to firm_path
  end

  private

    def firm_params
      params.require(:firm).permit(:name, :official_address, :rcs, :court_service,
             :bank_name, :bank_agency, :bank_agency_address, :bank_account, :valuation,
             :share_price, :initial_capital, :shares)
    end

    def find_firm
      @firm = Firm.find(params[:id])
    end

    def set_shares(id)
      params.require(:shareholder).fetch(id).permit(:shares)
    end

end
