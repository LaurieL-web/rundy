
# 1. Clean the database 🗑️
puts "Cleaning database..."
Session.destroy_all
Objective.destroy_all
User.destroy_all

# 2. Create the instances
user1 = User.create!(
  email: "alex@gmail.com",
  password: "password123",
  password_confirmation: "password123",
)

objective1 = Objective.create!(
  user: user1,
  distance: 10,
  target_time: "01:00:00",
  prepa_duration: 8,
  frequency: 3
)

Session.create!(
  objective: objective1,
  session_type: "EF",
  distance: 5,
  pace: "6:00/km",
  content: "Footing tranquille"
)

Session.create!(
  objective: objective1,
  session_type: "interval",
  distance: 6,
  pace: "5:00/km",
  content: "6 x 400m avec récupération"
)

Session.create!(
  objective: objective1,
  session_type: "long",
  distance: 8,
  pace: "6:15/km",
  content: "Sortie longue"
)


user2 = User.create!(
  email: "bob@gmail.com",
  password: "password123",
  password_confirmation: "password123",
)

objective2 = Objective.create!(
  user: user2,
  distance: 21.1,
  target_time: "02:00:00",
  prepa_duration: 12,
  frequency: 4
)

Session.create!(
  objective: objective2,
  session_type: "EF",
  distance: 7,
  pace: "6:00/km",
  content: "Footing récupération"
)

Session.create!(
  objective: objective2,
  session_type: "tempo",
  distance: 8,
  pace: "5:15/km",
  content: "Course à allure seuil"
)

Session.create!(
  objective: objective2,
  session_type: "interval",
  distance: 10,
  pace: "4:50/km",
  content: "5 x 1000m"
)

Session.create!(
  objective: objective2,
  session_type: "long",
  distance: 15,
  pace: "6:10/km",
  content: "Sortie longue"
)
user3 = User.create!(
  email: "julien@gmail.com",
  password: "password123",
  password_confirmation: "password123"
)

objective3 = Objective.create!(
  user: user3,
  distance: 5,
  target_time: "00:28:00",
  prepa_duration: 6,
  frequency: 3
)

Session.create!(
  objective: objective3,
  session_type: "EF",
  distance: 4,
  pace: "6:30/km",
  content: "Footing facile de récupération"
)

Session.create!(
  objective: objective3,
  session_type: "interval",
  distance: 5,
  pace: "5:00/km",
  content: "8 x 400m avec 1 min de récupération"
)

Session.create!(
  objective: objective3,
  session_type: "long",
  distance: 7,
  pace: "6:20/km",
  content: "Sortie longue progressive"
)


user4 = User.create!(
  email: "laurie@gmail.com",
  password: "password123",
  password_confirmation: "password123"
)

objective4 = Objective.create!(
  user: user4,
  distance: 42.2,
  target_time: "04:00:00",
  prepa_duration: 16,
  frequency: 4
)

Session.create!(
  objective: objective4,
  session_type: "EF",
  distance: 8,
  pace: "6:15/km",
  content: "Footing endurance fondamentale"
)

Session.create!(
  objective: objective4,
  session_type: "tempo",
  distance: 10,
  pace: "5:15/km",
  content: "2 x 4 km à allure marathon"
)

Session.create!(
  objective: objective4,
  session_type: "interval",
  distance: 12,
  pace: "4:45/km",
  content: "6 x 1000m avec récupération"
)

Session.create!(
  objective: objective4,
  session_type: "long",
  distance: 22,
  pace: "5:50/km",
  content: "Sortie longue avec les 5 derniers km à allure marathon"
)

# 3. Display a message
puts "Finished! Created #{User.count} users, #{Objective.count} objectives and #{Session.count} sessions."
