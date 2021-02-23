require 'rails_helper'

describe 'it can return a missions task with task details' do
  it 'can return the tasks' do
    mission = create(:mission)
    task1, task2, task3, task4 = create_list(:task, 4)
    mission.tasks << task1
    mission.tasks << task2
    mission.tasks << task3
    mission.tasks << task4

    get "/api/v1/missions/#{mission.id}/tasks"
    expect(response).to be_successful

    body = JSON.parse(response.body, symbolize_names: true)
  end
end