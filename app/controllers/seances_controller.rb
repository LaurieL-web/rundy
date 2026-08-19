class SeancesController < ApplicationController
  before_action :set_objective, only: [:show, :index]
  before_action :set_seance, only: [:edit, :update]

  def show
    @seance = Seance.find(params[:id])
  end

  def index
    @seances = @objective.seances.all
  end

  def update
    response = RubyLLM
      .chat
      .ask(prompt_update)

    @seance.update!(response.content)

    redirect_to seances_path
  end

  private
  def set_session
    @seance = Seance.find(params[:id])
  end

  def prompt_update
    <<~PROMPT
      You are an experienced running coach.

      Update this running seance based on the user's request.

      Current session:
      Session type: #{@seance.session_type}
      Distance: #{@seance.distance} km
      Pace: #{@seance.pace}
      Content: #{@seance.content}
      User request: #{params[:prompt]}

      Return the updated seance values. As a hash
    PROMPT
  end

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end
end
