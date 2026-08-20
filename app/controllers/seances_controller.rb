class SeancesController < ApplicationController
  before_action :set_objective, only: [:show, :index]
  before_action :set_seance, only: [:update]

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

  def update
    response = RubyLLM
      .chat
      .ask(prompt_update)

      @seance.update!(response.content)
      @objective = @seance.objective

      redirect_to objective_seances_path(@objective)
  end

  private
  def set_session
    @seance = Seance.find(params[:id])
  end

  def prompt_update
    <<~PROMPT
      You are an experienced running coach.
      my  goal is #{@objective}
      Current seance is #{@seance}
      Update this current seance based my goal.
      format your answer like this:
      {
        seance_type: "easy",
        distance: 6,
        pace: "6:15/km",
        content: "Course facile en endurance fondamentale"
      }
    PROMPT
  end

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end
end
