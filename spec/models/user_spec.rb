require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it { should have_many(:missions) }
    it 'mission_tasks' do
      user = create(:user)
      expect(user.mission_tasks.empty?).to be(true)
    end
  end

  describe 'instance_methods' do
    before :each do
      @user = create(:user)
      @mission1 = create(:mission, user_id: @user.id)
      @mission2 = create(:mission, user_id: @user.id)

      # house_chores
      @task9 = Task.create(name: 'clean room',
                           description: 'please',
                           category: 'house_chores',
                           points: 2)
      @task10 = Task.create(name: 'clean garage',
                            description: 'please',
                            category: 'house_chores',
                            points: 2)
      @task11 = Task.create(name: 'clean bathroom',
                            description: 'please',
                            category: 'house_chores',
                            points: 2)

      # physical training
      @task12 = Task.create(name: 'weed garden',
                            description: 'please',
                            category: 'physical_training',
                            points: 2)
      @task13 = Task.create(name: 'lift weights',
                            description: 'please',
                            category: 'physical_training',
                            points: 2)

      # brain_training
      @task14 = Task.create(name: 'read book',
                            description: 'please',
                            category: 'brain_training',
                            points: 2)
      @task15 = Task.create(name: 'do math',
                            description: 'please',
                            category: 'brain_training',
                            points: 2)

      # outdoor_training
      @task16 = Task.create(name: 'go hiking',
                            description: 'please',
                            category: 'outdoor_traning',
                            points: 2)

      @mt9 = MissionTask.create(task_id: @task9.id, mission_id: @mission1.id)
      @mt10 = MissionTask.create(task_id: @task10.id, mission_id: @mission1.id)
      @mt11 = MissionTask.create(task_id: @task11.id, mission_id: @mission1.id)
      @mt12 = MissionTask.create(task_id: @task12.id, mission_id: @mission1.id)
      @mt13 = MissionTask.create(task_id: @task13.id, mission_id: @mission2.id)
      @mt14 = MissionTask.create(task_id: @task14.id, mission_id: @mission2.id)
      @mt15 = MissionTask.create(task_id: @task15.id, mission_id: @mission2.id)
      @mt16 = MissionTask.create(task_id: @task16.id, mission_id: @mission2.id)

      MissionTask.find(@mt9.id).update(is_completed: true)
      MissionTask.find(@mt10.id).update(is_completed: true)
      MissionTask.find(@mt14.id).update(is_completed: true)
      MissionTask.find(@mt16.id).update(is_completed: true)
    end

    it 'set_defaults' do
      expect(@user.points).to eq(0)
    end

    it 'update_points' do
      @user.points = 50
      @user.save
      @user.update_points(30)
      expect(@user.points).to eq(20)
      @user.update_points(50)
      expect(@user.points).to_not eq(-30)
      expect(@user.points).to eq(20)
    end

    it 'user_stats' do
      stats = User.find_by(id: @user.id).user_stats
      arr_stats = stats.to_a
      arr_stats.each do |stat|
        expect(stat['user_id']).to eq(@user.id)
        expect(stat).to have_key('category')
        expect(stat).to have_key('total_tasks')
        expect(stat).to have_key('completed_tasks')
        expect(stat).to have_key('total_points')
        expect(stat).to have_key('completed_points')
      end
    end
  end
end
