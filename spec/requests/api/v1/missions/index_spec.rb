require 'rails_helper'

describe 'mission index api' do
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

  xit 'returns current missions' do
    missions = create_list(:mission, 10)
    get '/api/v1/missions', headers: @headers, params: JSON.generate(@body)
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data].count).to eq(10)
    json_response[:data].each do |mission|
      expect(mission[:attributes]).to have_key(:name)
      expect(mission[:attributes][:name]).to be_a(String)
      expect(mission[:attributes]).to have_key(:due_date)
      expect(mission[:attributes][:due_date]).to be_a(String)
      expect(mission[:attributes]).to have_key(:user_id)
      expect(mission[:attributes][:user_id]).to be_a(Integer)
      expect(mission[:attributes]).to have_key(:created_at)
      expect(mission[:attributes][:created_at]).to be_a(String)
      expect(mission[:attributes]).to have_key(:updated_at)
      expect(mission[:attributes][:updated_at]).to be_a(String)
    end
  end

  xit 'returns an empty array if no current missions' do
    get '/api/v1/missions', headers: @headers, params: JSON.generate(@body)
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data].empty?).to eq(true)
  end
end
