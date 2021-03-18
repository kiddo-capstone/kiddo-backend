
require 'csv'

MissionTask.destroy_all
Mission.destroy_all
User.destroy_all
Task.destroy_all
Parent.destroy_all

parent_1 = Parent.create(name: 'Calvin', email: 'Calvin@example.com')
parent_2 = Parent.create(name: 'Hobbes', email: 'Hobbes@example.com')

user_1 = User.create(name: 'Little Calvin', parent_id: parent_1.id, points: 123)
user_2 = User.create(name: 'Little Joey', parent_id: parent_1.id, points: 333)
user_3 = User.create(name: 'Little Hobbes', parent_id: parent_2.id, points: 111)
user_4 = User.create(name: 'Little Sam', parent_id: parent_2.id, points: 421)

reward_1 = Reward.create(title: 'Pizza Night', description: 'pizza for dinner', points_to_redeem: 30, parent_id: parent_1.id, user_id: user_1.id)
reward_2 = Reward.create(title: 'Candy Pick', description: 'choose a candy bar', points_to_redeem: 15, parent_id: parent_1.id, user_id: user_1.id)
reward_3 = Reward.create(title: 'Video Game Night', description: '1 hour to play video games', points_to_redeem: 30, parent_id: parent_1.id, user_id: user_1.id)
reward_4 = Reward.create(title: 'Basket Ball Hoop', description: 'Get that B-ball hoop for the driveway', points_to_redeem: 100, parent_id: parent_1.id, user_id: user_1.id)
reward_5 = Reward.create(title: 'Karate Lessons', description: 'Kung Foo!', points_to_redeem: 60, parent_id: parent_1.id, user_id: user_1.id)

reward_6 = Reward.create(title: 'Pizza Night', description: 'pizza for dinner', points_to_redeem: 30, parent_id: parent_1.id, user_id: user_2.id)
reward_7 = Reward.create(title: 'Candy Pick', description: 'choose a candy bar', points_to_redeem: 15, parent_id: parent_1.id, user_id: user_2.id)
reward_8 = Reward.create(title: 'Video Game Night', description: '1 hour to play video games', points_to_redeem: 30, parent_id: parent_1.id, user_id: user_2.id)
reward_9 = Reward.create(title: 'New Doll House', description: 'Because 10 is not enough!', points_to_redeem: 100, parent_id: parent_1.id, user_id: user_2.id)
reward_10 = Reward.create(title: 'Horse Riding Lessons', description: 'Horay for horses!', points_to_redeem: 100, parent_id: parent_1.id, user_id: user_2.id)

reward_11 = Reward.create(title: 'Pizza Night', description: 'pizza for dinner', points_to_redeem: 30, parent_id: parent_2.id, user_id: user_2.id)
reward_12 = Reward.create(title: 'Candy Pick', description: 'choose a candy bar', points_to_redeem: 15, parent_id: parent_2.id, user_id: user_2.id)
reward_13 = Reward.create(title: 'Video Game Night', description: '1 hour to play video games', points_to_redeem: 30, parent_id: parent_2.id, user_id: user_2.id)
reward_14 = Reward.create(title: 'New Doll House', description: 'Because 10 is not enough!', points_to_redeem: 100, parent_id: parent_2.id, user_id: user_2.id)
reward_15 = Reward.create(title: 'Horse Riding Lessons', description: 'Horay for horses!', points_to_redeem: 100, parent_id: parent_2.id, user_id: user_2.id)

reward_16 = Reward.create(title: 'Pizza Night', description: 'pizza for dinner', points_to_redeem: 30, parent_id: parent_2.id, user_id: user_1.id)
reward_17 = Reward.create(title: 'Candy Pick', description: 'choose a candy bar', points_to_redeem: 15, parent_id: parent_2.id, user_id: user_1.id)
reward_18 = Reward.create(title: 'Video Game Night', description: '1 hour to play video games', points_to_redeem: 30, parent_id: parent_2.id, user_id: user_1.id)
reward_19 = Reward.create(title: 'Basket Ball Hoop', description: 'Get that B-ball hoop for the driveway', points_to_redeem: 100, parent_id: parent_2.id, user_id: user_1.id)
reward_20 = Reward.create(title: 'Karate Lessons', description: 'Kung Foo!', points_to_redeem: 60, parent_id: parent_2.id, user_id: user_1.id)

mission_1 = Mission.create(name: 'Independence Day', due_date: Time.now + 1.day, user_id: user_1.id)
mission_2 = Mission.create(name: "Doom's Day", due_date: Time.now - 1.day, user_id: user_1.id)
mission_3 = Mission.create(name: 'Day of reckoning', due_date: Time.now + 1.year, user_id: user_2.id)

task_1 = Task.create(name: 'EQ level up', description: 'Say something kind', category: 'EQ', points: 100, photo: false)
task_2 = Task.create(name: 'IQ level up', description: 'Conquer homework', category: 'IQ', points: 50, photo: true)
task_3 = Task.create(name: 'Special', description: 'Make your bed', category: 'Misc', points: 1337, photo: true)

mission_task_11 = MissionTask.create(mission_id: mission_1.id,
                                    task_id: task_1.id,
                                    message: "I'm Baaack!",
                                    image_path: '',
                                    is_completed: false)

mission_task_12 = MissionTask.create(mission_id: mission_1.id,
                                    task_id: task_2.id,
                                    message: 'Nailed it!',
                                    image_path: '',
                                    is_completed: true)


mission_task_2 = MissionTask.create(mission_id: mission_2.id, task_id: task_2.id, message: 'Dog ate my homework',
                                    image_path: '', is_completed: true)
mission_task_3 = MissionTask.create(mission_id: mission_3.id, task_id: task_3.id, message: 'This too shall pass',
                                    image_path: '', is_completed: false)

#csv stuff
CSV.foreach(Rails.root.join('db/data/tasks.csv'), headers: true) do |row|
 Task.create(row.to_h)
end

ActiveRecord::Base.connection.reset_pk_sequence!('tasks')
