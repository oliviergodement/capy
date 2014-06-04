class RoundsController < ApplicationController

  before_action :find_firm, only: [:new, :create, :show, :index]
  before_action :authenticate_user!

  def new
    @round = Round.new
  end

  def create
    @round = Round.create(round_params)
    @round.update_attribute(:initial_round, false)
    redirect_to new_shareholder_path(@firm.id, @round.id)
  end

  def show
    @round = Round.find(params[:round_id])
  end

  def index
    @rounds = @firm.rounds
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def find_firm
      @firm = Firm.find(params[:id])
    end

    def round_params
      params.require(:round).permit(:name, :ownership_offered, :firm_id)
    end

    def set_amount(id)
      params.require(:investment).fetch(id).permit(:amount, :round_id)
    end

end
