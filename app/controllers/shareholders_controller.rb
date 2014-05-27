class ShareholdersController < ApplicationController

  before_action :find_firm, only: [:index, :create, :destroy]
  respond_to :js, :html

  def index
    @shareholder = Shareholder.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @firm.shareholders.create(shareholder_params)
    respond_with do |format|
      format.js
    end
  end

  def destroy
    @firm.shareholders.find(params[:shareholder_id]).destroy
    respond_with do |format|
      format.js
    end
  end

  private

    def find_firm
      @firm = Firm.find(params[:id])
    end

    def shareholder_params
      params.require(:shareholder).permit(:first_name, :last_name, :birth_date, :email, :address,
                    :nationality)
    end


end
