require 'rails_helper'

describe 'mission task show api' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)
    @headers = { 'CONTENT_TYPE' => 'application/json'}
    @body = {
             email: @calvin.email,
             auth_token: @calvin.auth_token
            }
  end

  xit 'returns current mission task' do
    mission = create(:mission)
    task1, task2, task3, task4 = create_list(:task, 4)
    mission.tasks << task1
    mission.tasks << task2
    mission.tasks << task3
    mission.tasks << task4
    mission_task = mission.mission_tasks.last

    get "/api/v1/mission_tasks/#{mission_task.id}", headers: @headers, params: @body
    expect(response).to be_successful
    json_body = JSON.parse(response.body, symbolize_names: true)
    expect(response).to be_successful
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
end
