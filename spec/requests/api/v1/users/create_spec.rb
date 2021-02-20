require 'rails_helper'

describe 'user create api' do
  it 'create a user' do
    user = {
      name: 'Iamaboss',
      email: 'Iamaboss@bossville.com'
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user)
    created_user = User.last
    expect(response).to be_successful
    expect(created_user.name).to eq(user[:name])
    expect(created_user.email).to eq(user[:email])
  end

  it 'it will not create user without email' do
    user = {
      name: 'Iamaboss',
      email: ''
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to be_a(String)
  end
  it 'it will not create user without name' do
    user = {
      name: '',
      email: 'Iamaboss@bossville.com'
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to be_a(String)
  end
  it 'it send back user if user exists' do
    user = {
      name: 'bubba',
      email: 'Iamaboss@bossville.com'
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/users', headers: headers, params: JSON.generate(user)
    created_user = User.last
    expect(response).to be_successful
    expect(created_user.name).to eq(user[:name])
    expect(created_user.email).to eq(user[:email])

    post '/api/v1/users', headers: headers, params: JSON.generate(user)
    returned_user = JSON.parse(response.body, symbolize_names: true)
    expect(returned_user[:data][:id]).to_not be_nil
  end
end
