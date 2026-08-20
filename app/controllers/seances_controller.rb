class SeancesController < ApplicationController
  before_action :set_objective, only: %i[show index]
  def show
    @seance = Seance.find(params[:id])
  end

  def destroy
    @seance = Seance.find(params[:id])
    @objective = @seance.objective
    @seance.destroy

    redirect_to objective_seances_path(@objective)
  end

  def index
    @seances = @objective.seances
  end

  def update
    raise
  end

  private

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end
end
