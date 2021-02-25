require 'rails_helper'

describe 'create task' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)

    @task = create(:task)
  end

  it 'can create a task' do

    body = { task_id: @task.id,
             name: @task.name,
             description: @task.description,
             category: @task.category,
             points: @task.points,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    created_task = Task.last
    expect(response).to be_successful
    expect(created_task.name).to eq(@task[:name])
    expect(created_task.description).to eq(@task[:description])
    expect(created_task.category).to eq(@task[:category])
    expect(created_task.points).to eq(@task[:points])
  end

  it 'it will not create a task without a name' do
    body = { task_id: @task.id,
             name: "",
             description: @task.description,
             category: @task.category,
             points: @task.points,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Name can't be blank")
  end

  it 'it will not create a task without a description' do
    body = { task_id: @task.id,
             name: @task.name,
             description: "",
             category: @task.category,
             points: @task.points,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Description can't be blank")
  end

  it 'it will not create a task without a category' do
    body = { task_id: @task.id,
             name: @task.name,
             description: @task.description,
             category: "",
             points: @task.points,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Category can't be blank")
  end

  it 'it will not create a task with 0 points' do
    body = { task_id: @task.id,
             name: @task.name,
             description: @task.description,
             category: @task.category,
             points: 0,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points must be greater than 0")
  end

  it 'it will not create a task with negative points' do
    body = { task_id: @task.id,
             name: @task.name,
             description: @task.description,
             category: @task.category,
             points: -3,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points must be greater than 0")
  end

  it 'it will not create a task with non integer values' do
    body = { task_id: @task.id,
             name: @task.name,
             description: @task.description,
             category: @task.category,
             points: 13.37,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: body.to_json
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points must be an integer")
  end
end
