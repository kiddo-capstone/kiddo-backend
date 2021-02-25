require 'rails_helper'

describe 'update task' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)
    @headers = { 'CONTENT_TYPE' => 'application/json'}
    @task = create(:task)
  end

  it 'can update a task' do
    body = { task_id: @task.id,
             name: @task.name,
             description: "New description",
             category: @task.category,
             points: @task.points,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }

    patch api_v1_task_path(@task.id), headers: @headers, params: JSON.generate(body)
    @task.reload
    expect(@task.id).to eq(@task.id)
    expect(@task.description).to eq('New description')
  end

  it 'cannot update a task to invalid entries' do
    body = { task_id: @task.id,
             name: "",
             description: @task.description,
             category: @task.category,
             points: @task.points,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }

    patch api_v1_task_path(@task.id), headers: @headers, params: JSON.generate(body)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data]).to have_key(:errors)
    expect(body[:data][:errors]).to eq("Name can't be blank")
  end
end
