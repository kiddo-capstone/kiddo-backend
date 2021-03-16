require 'rails_helper'

RSpec.describe MissionTask, type: :model do
  describe 'relationships' do
    it {should belong_to :mission}
    it {should belong_to :task}
    
  end

  describe 'instance methods' do
    before :each do
      @mission = create(:mission)
      @task = create(:task)
      @task2 = create(:task)
    end

    it 'set_defaults' do
      mt2 = MissionTask.create(mission_id: @mission.id, task_id: @task.id)
      expect(mt2.is_completed).to eq(false)
    end
    
    it 'completed' do 
      mt2 = MissionTask.create(mission_id: @mission.id, 
                               task_id: @task.id,
                               is_completed: true)
      mt3 = MissionTask.create(mission_id: @mission.id, 
                               task_id: @task2.id)
      
      completed = MissionTask.all.completed
      completed.each do |task|
        expect(task.is_completed).to eq(true)
      end
    end
  end
end
