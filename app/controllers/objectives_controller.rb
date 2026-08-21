class ObjectivesController < ApplicationController
  def create
    target_time = params[:objective][:target_time]
    if target_time.present?
      hours, minutes = target_time.split("h").map(&:to_i)
      target_time = Time.zone.local(2000, 1, 1, hours, minutes)
    end

    @objective = Objective.new(objective_params)
    @user = current_user
    @objective.user = @user
    if @objective.save!
      prompt = <<-PROMPT
      Tu es un coach de course à pied expert.

      Objectif : #{@objective.distance} km en #{@objective.target_time}
      Durée : #{@objective.prepa_duration} semaines
      Fréquence : #{@objective.frequency} séances par semaine

      Génère un programme progressif et cohérent incluant exclusivement les session_type : "Endurance", "Facile", "Sortie longue", "Tempo" ou "Seuil", "Fractionné" ou "Intervalles", "Récupération".

      CONTRAINTES STRICTES :
      - Réponds uniquement avec du Ruby valide, sans Markdown ni texte.
      - Le tableau doit contenir EXACTEMENT #{@objective.prepa_duration} semaines.
      - Chaque semaine doit contenir EXACTEMENT #{@objective.frequency} séances.
      - Nombre TOTAL de séances attendu : #{@objective.prepa_duration} × #{@objective.frequency}.
      - INTERDICTION d'ajouter une séance supplémentaire.
      - `week` va de 1 à #{@objective.prepa_duration}.
      - Chaque séance contient uniquement : `session_type`, `distance`, `pace`, `content`.
      - `session_type` doit être en français et utiliser uniquement : `"endurance"`, `"sortie_longue"`, `"tempo"`, `"fractionne"`, `"recuperation"`, `"course"`.
      - `distance` est en kilomètres.
      - `pace` est au format `MM:SS/km`.
      - `content` est précis et concis.
      - Les volumes et allures doivent être adaptés à l'objectif.
      - La charge progresse progressivement.
      - Les dernières semaines réduisent progressivement la charge avant la course.
      - Ne crée pas de semaine supplémentaire pour la course : la course fait partie des séances si elle est incluse dans le programme.

      FORMAT :
      seances = [
        {
          week: 1,
          seances: [
            {
              session_type: "endurance",
              distance: 6,
              pace: "6:15/km",
              content: "6 km en endurance fondamentale"
            }
          ]
        }
      ]

      AVANT DE RÉPONDRE, VÉRIFIE :
      - Nombre de semaines = #{@objective.prepa_duration}
      - Nombre de séances dans CHAQUE semaine = #{@objective.frequency}
      - Nombre TOTAL de séances = #{@objective.prepa_duration * @objective.frequency}
      - Aucune séance supplémentaire.

      PROMPT
      seances = RubyLLM.chat.ask(prompt).content
      eval(seances).each_with_index do |week, week_index|
        week[:seances].each_with_index do |seance, index|
          new_seance = Seance.new(seance)
          new_seance.index = index + 1
          new_seance.week_index = week_index + 1
          new_seance.objective = @objective
          new_seance.save
        end
      end
      redirect_to objective_seances_path(@objective)
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:distance, :target_time, :prepa_duration, :frequency)
  end
end
