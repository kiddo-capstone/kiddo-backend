require 'rails_helper'

describe 'create task' do
  it 'can create a task' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: 'Activity',
      points: 1337
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    created_task = Task.last
    expect(response).to be_successful
    expect(created_task.name).to eq(task[:name])
    expect(created_task.description).to eq(task[:description])
    expect(created_task.category).to eq(task[:category])
    expect(created_task.points).to eq(task[:points])
  end

  it 'it will not create a task without a name' do
    task = {
      name: '',
      description: 'Do the things to git good',
      category: "Activity",
      points: 1337
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Name can't be blank")
  end

  it 'it will not create a task without a description' do
    task = {
      name: 'Git Good',
      description: '',
      category: "Activity",
      points: 1337
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Description can't be blank")
  end

  it 'it will not create a task without a category' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: '',
      points: 1337
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Category can't be blank")
  end

  it 'it will not create a task with 0 points' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: 'Activity',
      points: 0
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points must be greater than 0")
  end

  it 'it will not create a task with negative points' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: 'Activity',
      points: -1337
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points must be greater than 0")
  end

  it 'it will not create a task with non integer values' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: 'Activity',
      points: 13.37
    }
    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Points must be an integer")
  end
end
