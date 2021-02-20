require 'rails_helper'

describe 'user index api' do
  it 'returns current users' do
    users = create_list(:user, 10)
    get '/api/v1/users'
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response[:data].count).to eq(10)
    json_response[:data].each do |user|
      expect(user[:attributes]).to have_key(:name)
      expect(user[:attributes][:name]).to be_a(String)
      expect(user[:attributes]).to have_key(:email)
      expect(user[:attributes][:email]).to be_a(String)
    end
  end
end
