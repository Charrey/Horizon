# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([{ username: 'alice', email: 'alice@email.com', password: 'password', password_confirmation: 'password' }])
User.create!([{ username: 'bob',   email: 'bob@email.com',   password: 'password', password_confirmation: 'password' }])

Roleplay.create!([{ user: User.find_by_username('alice'), name: 'Overwatch (18+ only)', image: File.new(File.join(Rails.root, '/app/assets/images/seed/Overwatch.png')), description: 'Only for 18+ people' }])
Character.create!([{ user: User.find_by_username('alice'), name: 'Narrator', image: File.new(File.join(Rails.root, '/app/assets/images/narrator.png')), description: 'Narrator for roleplay "Overwatch (18+ only)"', roleplay: Roleplay.find_by_name('Overwatch (18+ only)'), is_narrator: true }])

Roleplay.create!([{ user: User.find_by_username('bob'), name: 'Drakonite', image: File.new(File.join(Rails.root, '/app/assets/images/seed/dragon_icon.jpg')), description: 'Very good medieval RP', online: true }])
Character.create!([{ user: User.find_by_username('bob'), name: 'Narrator', image: File.new(File.join(Rails.root, '/app/assets/images/narrator.png')), description: 'Narrator for roleplay "Drakonite"', roleplay: Roleplay.find_by_name('Drakonite'), is_narrator: true }])

Roleplay.create!([{ user: User.find_by_username('bob'), name: 'Jerma Rumble', image: File.new(File.join(Rails.root, '/app/assets/images/seed/jerma.jpg')), description: 'Reenactment of the Jerma Rumble' }])
Character.create!([{ user: User.find_by_username('bob'), name: 'Narrator', image: File.new(File.join(Rails.root, '/app/assets/images/narrator.png')), description: 'Narrator for roleplay "Jerma Rumble"', roleplay: Roleplay.find_by_name('Jerma Rumble'), is_narrator: true }])

Character.create!([{ user: User.find_by_username('alice'), name: 'Widowmaker',           image: File.new(File.join(Rails.root, '/app/assets/images/seed/widowmaker.jpg')),  description: 'French person that is actually also evil',   roleplay: Roleplay.find_by_name('Overwatch (18+ only)') }])
Character.create!([{ user: User.find_by_username('alice'), name: 'Reaper',               image: File.new(File.join(Rails.root, '/app/assets/images/seed/reaper.jpg')),      description: 'Half-dead evil person',                      roleplay: Roleplay.find_by_name('Overwatch (18+ only)') }])
Character.create!([{ user: User.find_by_username('alice'), name: 'Mary',                 image: File.new(File.join(Rails.root, '/app/assets/images/seed/mary_square.jpg')), description: 'Attractive and capable member of the Guard', roleplay: Roleplay.find_by_name('Drakonite') }])
Character.create!([{ user: User.find_by_username('alice'), name: 'Glue Man de Grossi',   image: File.new(File.join(Rails.root, '/app/assets/images/seed/glueman.png')),     description: 'Really weird looking guy.',                  roleplay: Roleplay.find_by_name('Jerma Rumble') }])
