class SeancesController < ApplicationController
<<<<<<< HEAD
=======
  before_action :set_objective, only: [ :show, :index]
>>>>>>> master
  def show
    @seance = Seance.find(params[:id])
  end

<<<<<<< HEAD
  def destroy
    @seance = Seance.find(params[:id])
    @seance.destroy

    redirect_to root_path
    # rediction à changer où ?
  end
=======
  def index
    @seances = @objective.seances.all
  end

  private

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end

>>>>>>> master
end
