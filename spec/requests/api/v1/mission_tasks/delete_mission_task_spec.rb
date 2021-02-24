require 'rails_helper'

describe 'mission_tasks' do
  it 'can delete a mission task' do
    mission = create(:mission)
    task1 = create(:task)
    mission.tasks << task1
    mission_task = mission.mission_tasks.first
    delete "/api/v1/mission_tasks/#{mission_task.id}"
    expect(response).to be_successful
    expect(MissionTask.count).to eq(0)
    expect{ MissionTask.find(mission_task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
