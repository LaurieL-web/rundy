class ObjectivesController < ApplicationController

  def new
    @objective = Objective.new
  end
  def create
    @objective = Objective.new(objective_params)
    @user = current_user
    @objective.user = @user
    if @objective.save
      redirect_to sessions_path(@objective)
    else
      redirect_to root_path
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:distance, :target_time, :prepa_duration, :frequency)
  end
end
