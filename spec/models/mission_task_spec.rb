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
    end

    it 'set_defaults' do
      mt2 = MissionTask.create(mission_id: @mission.id, task_id: @task.id)
      expect(mt2.is_completed).to eq(false)
    end
  end
end
