require 'rails_helper'

describe 'task destroy' do
  it 'can destroy a task' do
    task = create(:task)
    expect(Task.count).to eq(1)
    delete "/api/v1/tasks/#{task.id}"
    expect(response).to be_successful
    expect(Task.count).to eq(0)
    expect{ Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'can destroy a task when its connected to mission_task' do
    task = create(:task)
    mission = create(:mission)
    mission.tasks << task
    delete "/api/v1/tasks/#{task.id}"
    expect(response).to be_successful
    expect(Task.count).to eq(0)
    expect{ Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'sends an error json when tryign to destroy an invalid task' do
    
    delete "/api/v1/tasks/17"
    expect(response.status).to eq(400)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Unable to destroy task.", :status=>"bad_request"}}
    expect(expected).to eq(response_body)
  end
end
