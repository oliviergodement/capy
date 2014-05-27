class ShareholdersController < ApplicationController

  respond_to :js, :html

  def index
    @firm = Firm.find(params[:id])
    @shareholder = Shareholder.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @firm = Firm.find(params[:id])
    @firm.shareholders.create(shareholder_params)
    respond_with do |format|
      format.js
    end
  end

  def destroy
    @firm = Firm.find(params[:id])
    @firm.shareholders.find(params[:shareholder_id]).destroy
    respond_with do |format|
      format.js
    end
  end

  private

    def shareholder_params
      params.require(:shareholder).permit(:first_name, :last_name, :birth_date, :email, :address,
                    :nationality)
    end


end
