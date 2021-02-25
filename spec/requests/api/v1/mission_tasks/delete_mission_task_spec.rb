require 'rails_helper'

describe 'mission_tasks' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)
  end

  it 'can delete a mission task' do
    mission = create(:mission)
    task_1 = create(:task)
    mission.tasks << task_1
    mission_task = mission.mission_tasks.first

    body = { mission_id: mission.id, task_id: task_1.id, email: @calvin.email, auth_token: @calvin.auth_token }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    delete "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
    expect(response).to be_successful
    expect(MissionTask.count).to eq(0)
    expect{ MissionTask.find(mission_task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
