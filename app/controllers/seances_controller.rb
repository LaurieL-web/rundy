class SeancesController < ApplicationController
  before_action :set_objective, only: %i[show index update_status]
  before_action :set_seance, only: %i[show destroy update_status]
  def show;end

  def destroy
    @seance.destroy

    redirect_to root_path
    # rediction à changer où ?
  end

  def index
    @seances = @objective.seances
  end

  def update_status
    @seance.status = !@seance.status
    @seance.save
  end

  private

  def set_seance
    @seance = Seance.find(params[:id])
  end

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end
end
