require 'rails_helper'

describe 'user show api' do
  it 'returns current user' do
    create(:user)
    user = User.last

    get "/api/v1/users/#{user.id}"
    expect(response).to be_successful
    json_response = JSON.parse(response.body, symbolize_names: true)
    expect(json_response.count).to eq(1)
    expect(json_response[:data][:attributes]).to have_key(:name)
    expect(json_response[:data][:attributes][:name]).to be_a(String)
    expect(json_response[:data][:attributes]).to have_key(:email)
    expect(json_response[:data][:attributes][:email]).to be_a(String)
  end
end
