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
    expect(body).to have_key(:data)
    task = body[:data].first
    expect(task).to have_key(:id)
    expect(task).to have_key(:type)
    expect(task).to have_key(:attributes)
    task_detail = task[:attributes]
    expect(task_detail).to have_key(:task_id)
    expect(task_detail).to have_key(:mission_id)
    expect(task_detail).to have_key(:task_name)
    expect(task_detail).to have_key(:task_description)
    expect(task_detail).to have_key(:points)
    expect(task_detail).to have_key(:task_category)
    expect(task_detail).to have_key(:message)
    expect(task_detail).to have_key(:image_path)
    expect(task_detail).to have_key(:is_completed)
  end

  it 'returns an error json if mission id doesnt exist' do
    get "/api/v1/missions/423/tasks"

    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"mission does not exist.", :status=>"bad_request"}}
    expect(body).to eq(expected)
  end
end