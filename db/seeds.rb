# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

MissionTask.destroy_all
Mission.destroy_all
User.destroy_all
Task.destroy_all


user_1 = User.create(name: 'Calvin', email: 'Calvin@example.com')
user_2 = User.create(name: 'Hobbes', email: 'Hobbes@example.com')

mission_1 = Mission.create(name: 'Independence Day', due_date: Time.now + 1.day, user_id: user_1.id)
mission_2 = Mission.create(name: "Doom's Day", due_date: Time.now - 1.day, user_id: user_1.id)
mission_3 = Mission.create(name: 'Day of reckoning', due_date: Time.now + 1.year, user_id: user_2.id)

task_1 = Task.create(name: 'EQ level up', description: 'Say something kind', category: 'EQ', points: 100)
task_2 = Task.create(name: 'IQ level up', description: 'Conquer homework', category: 'IQ', points: 50)
task_3 = Task.create(name: 'Special', description: 'Make your bed', category: 'Misc', points: 1337)

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
