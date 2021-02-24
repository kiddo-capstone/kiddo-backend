require 'rails_helper'

describe 'update task' do
  it 'can update a task' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: 'Activity',
      points: 1337
    }
    task_params = {
      name: 'got good',
      description: 'Done',
      category: 'Something else',
      points: 42
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    updated_task = Task.last

    patch api_v1_task_path(updated_task.id), headers: headers, params: JSON.generate(task_params)
    updated_task.reload
    expect(updated_task.name).to eq('got good')
    expect(updated_task.description).to eq('Done')
    expect(updated_task.category).to eq('Something else')
    expect(updated_task.points).to eq(42)
  end

  it 'cannot update a task to invalid entries' do
    task = {
      name: 'Git Good',
      description: 'Do the things to git good',
      category: 'Activity',
      points: 1337
    }
    task_params = {
      name: '',
      description: 'Done',
      category: 'Something else',
      points: 42
    }

    headers = { 'CONTENT_TYPE' => 'application/json'}
    post '/api/v1/tasks', headers: headers, params: JSON.generate(task)
    updated_task = Task.last

    patch api_v1_task_path(updated_task.id), headers: headers, params: JSON.generate(task_params)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Name can't be blank")
  end
end
