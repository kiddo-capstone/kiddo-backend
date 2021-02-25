require 'rails_helper'

describe 'task index api' do
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

  xit 'returns current tasks' do
    tasks = create_list(:task, 10)

    get '/api/v1/tasks', headers: @headers, params: JSON.generate(@body)
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data].count).to eq(10)
    json_response[:data].each do |task|
      expect(task[:attributes]).to have_key(:name)
      expect(task[:attributes][:name]).to be_a(String)
      expect(task[:attributes]).to have_key(:description)
      expect(task[:attributes][:description]).to be_a(String)
      expect(task[:attributes]).to have_key(:category)
      expect(task[:attributes][:category]).to be_a(String)
      expect(task[:attributes]).to have_key(:points)
      expect(task[:attributes][:points]).to be_a(Integer)
    end
  end
end
