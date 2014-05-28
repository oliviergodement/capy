class ShareholdersController < ApplicationController

  before_action :find_firm, only: [:add_initial_shareholders, :create, :destroy, :new_round_shareholder, :create_round_shareholder]
  respond_to :js, :html

  def add_initial_shareholders
    @shareholder = Shareholder.new
    @round = Round.find(params[:round_id])
  end

  def show
  end

  def edit
  end

  def update
  end

  def create
    @shareholder = @firm.shareholders.create(shareholder_params)
    if @firm.rounds.any?
      @shareholder.update_attribute(:initial_investor, false)
    else
      @shareholder.update_attribute(:initial_investor, true)
    end
    @round = Round.find(params[:round_id])
    Investment.create(firm_id: @firm.id, shareholder_id: @shareholder.id, round_id: @round.id)
    respond_with do |format|
      format.js
    end
  end

  def new_round_shareholder
    @shareholder = Shareholder.new
    @round = Round.find(params[:round_id])
  end

  def create_round_shareholder
    @shareholder = @firm.shareholders.create(shareholder_params)
    Investment.create(firm_id: @firm.id, shareholder_id: @shareholder.id)
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
                    :nationality, :initial_investor)
    end


end
