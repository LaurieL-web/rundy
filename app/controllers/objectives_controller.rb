class ObjectivesController < ApplicationController
<<<<<<< HEAD

  def create
    @objective = Objective.new(objective_params)
    @user = current_user
    @objective.user = @user
    if @objective.save
      redirect_to sessions_path(@objective)
      prompt = <<-PROMPT
      Tu es mon coach de course à pied expérimenté. Je souhaite préparer une course de #{@objective.distance} km avec pour objectif de la terminer en #{@objective.target_time}.
      Construis-moi un programme d’entraînement de #{@objective.prepa_duration} semaines, avec #{@objective.frequency} séances de course par semaine.
      Le programme doit être progressif et inclure les différents types de séances nécessaires : sorties faciles, sorties longues, séances tempo/seuil, intervalles et récupération/allègement avant la course.
      Pour chaque séance, indique uniquement :
      session_type
      distance
      pace
      content
      Les séances doivent être claires, concises et précisément définies, sans explications supplémentaires.
      Réponds uniquement avec le format Ruby suivant, compatible avec Ruby on Rails :
      sessions = [
        {
          week: 1,
          sessions: [
            {
              session_type: "easy",
              distance: 6,
              pace: "6:15/km",
              content: "Course facile en endurance fondamentale"
            },
            {
              session_type: "tempo",
              distance: 8,
              pace: "5:25/km",
              content: "2 km échauffement + 4 km à allure seuil + 2 km retour au calme"
            }
          ]
        },
        {
          week: 2,
          sessions: [
            {
              session_type: "easy",
              distance: 6,
              pace: "6:10/km",
              content: "Course facile en endurance fondamentale"
            }
          ]
        }
      ]
      PROMPT
      sessions = RubyLLM.chat.ask(prompt).content



    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:distance, :target_time, :prepa_duration, :frequency)
=======
  def new
    @objective = Objective.new
>>>>>>> master
  end
end
