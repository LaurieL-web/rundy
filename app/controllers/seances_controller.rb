class SeancesController < ApplicationController
  before_action :set_objective, only: %i[show index]
  def show
    @seance = Seance.find(params[:id])
  end

  def destroy
    @seance = Seance.find(params[:id])
    @seance.destroy

    redirect_to root_path
    # rediction à changer où ?
  end

  def index
    @seances = @objective.seances
  end

  private

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end
end
