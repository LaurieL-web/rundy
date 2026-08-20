class SeancesController < ApplicationController
  before_action :set_objective, only: [:show, :index, :update]

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

  def edit

  end
  def update
    @seance = Seance.find(params[:id])

    #response = RubyLLM.chat.ask(prompt_update)
    #parsed = JSON.parse(response.content)
    parsed = { "session_type" => nil, "distance" => 10, "pace" => "5:00", "content" => "test" }

    if @seance.update(
      session_type: parsed["session_type"],
      distance: parsed["distance"],
      pace: parsed["pace"],
      content: parsed["content"]
      )
      redirect_to objective_seance_path(@objective, @seance),
                notice: "Séance mise à jour ✅."
    else
      flash.now[:alert] = "🪲 Bug dans la matrice"
      render :show, status: :unprocessable_entity
    end
  end

  private
  def prompt_update
    <<~PROMPT
      Tu es un coach de course à pied expert.

      Objectif

      * #{@objective.distance} km en #{@objective.target_time}
      * Préparation : #{@objective.prepa_duration} semaines
      * Fréquence : #{@objective.frequency} séances/semaine

      Séance actuelle

      * type: #{@seance.session_type}
      * distance: #{@seance.distance} km
      * allure: #{@seance.pace}
      * contenu: #{@seance.content}

      Tâche

      Adapte cette séance pour qu’elle soit cohérente avec l’objectif, la durée de préparation et la fréquence d’entraînement. Conserve son intention autant que possible.

      Règles

      * session_type: string, de préférence easy, long, tempo, interval, recovery, threshold ou race
      * distance: number en km, jamais une string
      * pace: string en min/km, format M:SS/km
      * content: string courte et exploitable par le coureur
      * Exactement ces 4 clés, dans cet ordre
      * Aucune clé supplémentaire
      * Aucun texte, Markdown ou commentaire hors du JSON
      * Réponse = JSON valide uniquement, avec guillemets doubles

      Format obligatoire

      {
      "session_type": "easy",
      "distance": 6,
      "pace": "6:15/km",
      "content": "Course facile en endurance fondamentale"
      }

      Vérifie silencieusement avant de répondre

      JSON valide · 4 clés exactes · types corrects · cohérence avec l’objectif · aucun texte hors JSON.

      Retourne uniquement le JSON.
    PROMPT
  end

  def set_objective
    @objective = Objective.find(params[:objective_id])
  end
end
