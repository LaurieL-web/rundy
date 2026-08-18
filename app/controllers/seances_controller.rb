class SeancesController < ApplicationController
  before_action :set_objective, only: [ :show, :index]
  def show
    @seance = Seance.find(params[:id])
  end

  def index
    @seances = @objective.seances.all
  end

  private

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end

end
