class ShareholdersController < ApplicationController

  before_action :find_firm, only: [:new, :create, :destroy]
  before_action :find_round, only: [:new, :create, :destroy]
  respond_to :js, :html

  def new
    @shareholder = Shareholder.new
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @shareholder = @firm.shareholders.create(shareholder_params)
    if @round.initial_round
      @shareholder.update_attribute(:initial_investor, true)
    else
      @shareholder.update_attribute(:initial_investor, false)
    end
    @round = Round.find(params[:round_id])
    respond_with do |format|
      format.js
    end
  end

  def destroy
    Shareholder.find(params[:shareholder_id]).destroy
    respond_with do |format|
      format.js
    end
  end

  private

    def find_firm
      @firm = Firm.find(params[:id])
    end

    def find_round
      @round = Round.find(params[:round_id])
    end

    def shareholder_params
      params.require(:shareholder).permit(:first_name, :last_name, :birth_date, :email, :address,
                    :nationality, :initial_investor, :city, :country, :postal_code)
    end


end
