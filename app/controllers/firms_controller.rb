class FirmsController < ApplicationController

  before_action :find_firm, only: [:show, :edit, :update, :destroy, :shareholders, :create_shareholder]
  respond_to :js, :html

  def index
    @firms = Firm.all
  end

  def show
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
    redirect_to @firm
  end

  def destroy
    @firm.destroy
    redirect_to firms_path
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

end
