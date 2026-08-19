class SeancesController < ApplicationController
  before_action :set_objective, only: [ :show, :index]
  before_action :set_session, only: [:edit, :update]
  
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

    @session.update!(response.content)

    redirect_to sessions_path
  end

  private
  def set_session
    @session = Session.find(params[:id])
  end

  def prompt_update
    <<~PROMPT
      You are an experienced running coach.

      Update this running session based on the user's request.

      Current session:
      Session type: #{@session.session_type}
      Distance: #{@session.distance} km
      Pace: #{@session.pace}
      Content: #{@session.content}
      User request: #{params[:prompt]}

      Return the updated session values. As a hash
    PROMPT
  end

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end

end
