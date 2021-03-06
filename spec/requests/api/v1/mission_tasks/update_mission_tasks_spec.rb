require 'rails_helper'

describe ' mission tasks' do
  it 'can update a mission task even if no image' do
    mission = create(:mission)
    user = mission.user
    user_pts = mission.user.points
    task1 = create(:task)
    task_pts = task1.points
    mission.tasks << task1
    mission_task = mission.mission_tasks[0]
    body = { is_completed: true, message: 'Im done!!' }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    user.reload
    expect(user.points).to eq(task_pts)
    expect(json_body[:data][:id].to_i).to be_a Integer
    expect(json_body[:data][:type]).to eq('mission_task')
    expect(json_body[:data][:attributes]).to have_key(:is_completed)
    expect(json_body[:data][:attributes][:is_completed]).to eq(true)
    expect(json_body[:data][:attributes]).to have_key(:message)
    expect(json_body[:data][:attributes][:message]).to eq('Im done!!')
    expect(json_body[:data][:attributes]).to have_key(:mission_id)
    expect(json_body[:data][:attributes][:mission_id]).to be_a(Integer)
    expect(json_body[:data][:attributes]).to have_key(:task_id)
    expect(json_body[:data][:attributes][:task_id]).to be_a(Integer)
    expect(json_body[:data][:attributes]).to have_key(:image_path)
  end

  it 'can update a user score when task is completed/uncompleted' do
    mission = create(:mission)
    user = mission.user
    user_pts = mission.user.points
    task1 = create(:task)
    task_pts = task1.points
    mission.tasks << task1
    mission_task = mission.mission_tasks[0]
    
    #changing completion status from false to true, should add score
    body = { is_completed: true, message: 'Im done!!' }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    
    user.reload
    expect(user.points).to eq(user_pts + task_pts)

    #not changing completion status, score should not change
    body = { is_completed: true, message: 'Im done!!' }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)

    user.reload
    #score should not change from previous value
    expect(user.points).to eq(user_pts + task_pts)

    #changing completion from true to false, task value should subtracted from current
    body = { is_completed: false, message: 'Im done!!' }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)

    user.reload
    #score should no longer reflect the task points
    expect(user.points).to eq(user_pts)

    #not changing completion status, score should not change
    body = { is_completed: false, message: 'Im done!!' }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)

    user.reload
    #score should not change from previous value
    expect(user.points).to eq(user_pts)
  end

  it 'can update a mission task if an image is passed' do
    
    image_file = fixture_file_upload('spec/fixtures/new_math.png', 'png')
    mission = create(:mission)
    task1 = create(:task)
    mission.tasks << task1
    mission_task = mission.mission_tasks[0]
    body = { is_completed: true, message: 'Im done!!', image: image_file}
    headers = { 'CONTENT_TYPE' => 'multipart/form-data' }
    patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    expect(json_body[:data][:id].to_i).to be_a Integer
    expect(json_body[:data][:type]).to eq('mission_task')
    expect(json_body[:data][:attributes]).to have_key(:is_completed)
    expect(json_body[:data][:attributes][:is_completed]).to eq(true)
    expect(json_body[:data][:attributes]).to have_key(:message)
    expect(json_body[:data][:attributes][:message]).to eq('Im done!!')
    expect(json_body[:data][:attributes]).to have_key(:mission_id)
    expect(json_body[:data][:attributes][:mission_id]).to be_a(Integer)
    expect(json_body[:data][:attributes]).to have_key(:task_id)
    expect(json_body[:data][:attributes][:task_id]).to be_a(Integer)
    expect(json_body[:data][:attributes]).to have_key(:image_path)
    expect(json_body[:data][:attributes][:image_path]).to be_a(String)

  end

  it 'gets error message when cant find mission task' do
    mission = create(:mission)
    task1 = create(:task)
    mission.tasks << task1
    mission_task = mission.mission_tasks[700]
    body = { is_completed: true, message: 123_123 }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    patch '/api/v1/mission_tasks/700', headers: headers, params: body.to_json
    expect(response).to_not be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    expect(json_body).to have_key(:data)
    expect(json_body[:data]).to have_key(:errors)
    expect(json_body[:data][:errors]).to eq('mission task does not exist.')
  end
end
