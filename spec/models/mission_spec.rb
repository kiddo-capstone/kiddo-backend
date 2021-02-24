require 'rails_helper'

RSpec.describe Mission, type: :model do
  describe 'relationships' do
    it {should have_many :mission_tasks}
    it {should have_many(:tasks).through(:mission_tasks)}
    it {should belong_to(:user)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :due_date}
    it {should validate_presence_of :user_id}
  end

  describe 'class methods' do
    it 'get_tasks' do
      mission = create(:mission)
      task1, task2, task3, task4 = create_list(:task, 4)
      mission.tasks << task1
      mission.tasks << task2
      mission.tasks << task3
      mission.tasks << task4

      expected = Mission.get_tasks(mission.id)
      expected.each do |task|
        expect(task).to be_a Task
      end

      expected = Mission.get_tasks(2343)
      expect(expected).to be_nil
    end
  end
end
