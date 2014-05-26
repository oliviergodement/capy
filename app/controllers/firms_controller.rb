class FirmsController < ApplicationController
  def index
    @firms = Firm.all
  end

  def show
    @firm = Firm.find(params[:id])
  end

  def new
    @firm = Firm.new
  end

  def create
    @firm = Firm.new(firm_params)
    @firm.save
    redirect_to @firm
  end

  def edit
    @firm = Firm.find(params[:id])
  end

  def update
    @firm = Firm.find(params[:id])
    @firm.update(firm_params)
    redirect_to @firm
  end

  def destroy
    Firm.find(params[:id]).destroy
    redirect_to firms_path
  end

  private

    def firm_params
      params.require(:firm).permit(:name, :official_address, :rcs, :court_service,
             :bank_name, :bank_agency, :bank_agency_address, :bank_account, :valuation,
             :share_price, :initial_capital, :shares)
    end

end
