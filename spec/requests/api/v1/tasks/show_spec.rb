require 'rails_helper'

describe 'task show api' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)
    @headers = { 'CONTENT_TYPE' => 'application/json'}
    @task = create(:task)
    @body = {
             email: @calvin.email,
             auth_token: @calvin.auth_token
            }
  end

  xit 'returns current task' do
    get "/api/v1/tasks/#{@task.id}", headers: @headers, params: @body
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.count).to eq(1)
    expect(json_response[:data][:attributes]).to have_key(:name)
    expect(json_response[:data][:attributes][:name]).to be_a(String)
    expect(json_response[:data][:attributes]).to have_key(:description)
    expect(json_response[:data][:attributes][:description]).to be_a(String)
    expect(json_response[:data][:attributes]).to have_key(:category)
    expect(json_response[:data][:attributes][:category]).to be_a(String)
    expect(json_response[:data][:attributes]).to have_key(:points)
    expect(json_response[:data][:attributes][:points]).to be_a(Integer)
  end
end
