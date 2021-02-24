require 'rails_helper'

describe 'mission tasks' do
  it 'can create a mission task' do
    mission = create(:mission)
    task_1 = create(:task)

    body = { mission_id: mission.id, task_id: task_1.id }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/mission_tasks', headers: headers, params: body.to_json
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    expect(json_body).to have_key(:data)
    expect(json_body[:data]).to have_key(:id)
    expect(json_body[:data][:id]).to be_a(String)
    expect(json_body[:data]).to have_key(:type)
    expect(json_body[:data][:type]).to be_a(String)
    expect(json_body[:data]).to have_key(:attributes)
    expect(json_body[:data][:attributes]).to be_a(Hash)
    expect(json_body[:data][:attributes]).to have_key(:is_completed)
    expect(json_body[:data][:attributes][:is_completed]).to eq(false)
    expect(json_body[:data][:attributes]).to have_key(:message)
    expect(json_body[:data][:attributes][:message]).to be_nil
    expect(json_body[:data][:attributes]).to have_key(:mission_id)
    expect(json_body[:data][:attributes][:mission_id]).to be_a(Integer)
    expect(json_body[:data][:attributes]).to have_key(:task_id)
    expect(json_body[:data][:attributes][:task_id]).to be_a(Integer)
    expect(json_body[:data][:attributes]).to have_key(:image_path)
    expect(json_body[:data][:attributes][:image_path]).to be_nil
  end
  it 'get error code when missing mission id' do
    mission = create(:mission)
    task_1 = create(:task)

    body = { mission_id: '', task_id: task_1.id }
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/mission_tasks', headers: headers, params: body.to_json
    expect(response).to_not be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    expect(json_body).to have_key(:data)
    expect(json_body[:data]).to have_key(:errors)
    expect(json_body[:data][:errors]).to eq("Mission must exist")
    expect(json_body[:data]).to have_key(:status)
    expect(json_body[:data][:status]).to eq("bad_request")
  end
  
  it 'gets error code when missing task id' do
    mission = create(:mission)
    task_1 = create(:task)
    body = { mission_id: mission.id, task_id: ''}
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/mission_tasks', headers: headers, params: body.to_json
    expect(response).to_not be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    expect(json_body).to have_key(:data)
    expect(json_body[:data]).to have_key(:errors)
    expect(json_body[:data][:errors]).to eq("Task must exist")
    expect(json_body[:data]).to have_key(:status)
    expect(json_body[:data][:status]).to eq("bad_request")
  end
end
