require 'rails_helper'

describe 'parent create api' do
  it 'create a parent' do
    parent = {
      name: 'Iamaboss',
      email: 'Iamaboss@bossville.com'
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/parents', headers: headers, params: JSON.generate(parent)
    created_parent = Parent.last
    expect(response).to be_successful
    expect(created_parent.name).to eq(parent[:name])
  end

  it 'it will not create parent without email' do
    parent = {
      name: 'Iamaboss',
      email: ''
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/parents', headers: headers, params: JSON.generate(parent)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to be_a(String)
  end
  it 'it will not create parent without name' do
    parent = {
      name: '',
      email: 'Iamaboss@bossville.com'
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/parents', headers: headers, params: JSON.generate(parent)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to be_a(String)
  end
  it 'it send back parent if parent exists' do
    parent = {
      name: 'bubba',
      email: 'Iamaboss@bossville.com'
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/parents', headers: headers, params: JSON.generate(parent)
    created_parent = Parent.last
    expect(response).to be_successful
    expect(created_parent.name).to eq(parent[:name])
    expect(created_parent.email).to eq(parent[:email])
    expect(created_parent.email).to eq(parent[:email])
  
    post '/api/v1/parents', headers: headers, params: JSON.generate(parent)
    returned_parent = JSON.parse(response.body, symbolize_names: true)
    expect(returned_parent[:data][:id]).to_not be_nil
  end

  it 'it can verify parents have users' do
    parent = create(:parent)
    child = create(:user, parent_id: parent.id)
    body = {
        name: parent.name,
        email: parent.email
      }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/parents', headers: headers, params: JSON.generate(body)
    returned_parent = JSON.parse(response.body, symbolize_names: true)
    expect(returned_parent[:data][:id]).to_not be_nil    
    expect(returned_parent[:data][:relationships][:users][:data][0][:id]).to eq("#{child.id}")
  end
end
