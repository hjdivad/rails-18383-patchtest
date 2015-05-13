# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

srand(24601)

WarGoals = %w(blogs calculators coffees teas macbooks headphones slack_clients hubots git_repos keyboards cities cars walls routers modems books)
BattleFields = %w(sainsburys safeway peets starbucks costco microsoft redmond mission market noisy_music cubicles dilbert)

Participant.destroy_all
Battle.destroy_all
War.destroy_all

participants_to_create = 100
participants_to_create.times do |n|
  Participant.create!({ name: Faker::Name.name })
end

participants = Participant.all

wars_to_create = 50
wars_to_create.times do |n|
  name = "War of the #{rand(10)+1} #{WarGoals.sample}"

  war = War.create!({ name: name })

  battles_to_create = rand(10) + 1
  battles_to_create.times do |m|
    name = "Battle of #{BattleFields.sample}"
    people_involved = (0..rand(5)).map{ participants.sample }.uniq

    war.battles.create!({ name: name, participants: people_involved })
  end
end
