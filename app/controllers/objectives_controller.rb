class ObjectivesController < ApplicationController
  def create
    @objective = Objective.new(objective_params)
    @user = current_user
    @objective.user = @user
    if @objective.save!
      redirect_to objective_seances_path(@objective)
      prompt = <<-PROMPT
      Tu es un coach de course à pied expert.
      Objectif : #{@objective.distance} km en #{@objective.target_time}
      Durée : #{@objective.prepa_duration} semaines
      Fréquence : #{@objective.frequency} séances/semaine
      Génère un programme progressif et cohérent incluant selon les besoins : endurance facile, sortie longue, tempo/seuil, fractionné/intervalles, récupération et allègement avant la course.
      CONTRAINTES :
      - Réponds uniquement en Ruby valide, sans Markdown ni texte supplémentaire.
      - Variable racine : `seances`.
      - Exactement #{@objective.prepa_duration} objets = 1 objet par semaine.
      - `week` va de 1 à #{@objective.prepa_duration}.
      - Chaque semaine contient exactement #{@objective.frequency} séances.
      - Ne jamais mélanger les séances entre les semaines.
      - Chaque séance contient uniquement : `seance_type`, `distance`, `pace`, `content`.
      - `distance` est en kilomètres.
      - `pace` est au format `MM:SS/km`.
      - `content` est précis et concis, avec échauffement, blocs et retour au calme si nécessaire.
      - Les volumes et allures doivent être adaptés à l'objectif.
      - La charge doit progresser progressivement.
      - Prévoir un allègement avant la course.
      FORMAT EXACT :
      [
        {
          week: 1,
          seances: [
            {
              session_type: "easy",
              distance: 6,
              pace: "6:15/km",
              content: "6 km en endurance fondamentale"
            }
          ]
        }
      ]
      Vérifier avant de répondre :
      #{@objective.prepa_duration} semaines × #{@objective.frequency} séances.
      PROMPT
      seances = RubyLLM.chat.ask(prompt).content
      eval(seances).each do |week|
        week[:seances].each do |seance|
          new_seance = Seance.new(seance)
          new_seance.objective = @objective
          new_seance.save
        end
      end
    else
      redirect_to root_path, status: :unprocessable_entity
    end
  end

  private

  def objective_params
    params.require(:objective).permit(:distance, :target_time, :prepa_duration, :frequency)
  end
end
