require 'rails_helper'

describe 'task destroy' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)

    @task = create(:task)
  end

  it 'can destroy a task' do
    expect(Task.count).to eq(1)

    headers = { 'CONTENT_TYPE' => 'application/json'}
    body = { id: @task.id,
             email: @calvin.email,
             auth_token: @calvin.auth_token
           }

    delete "/api/v1/tasks/#{@task.id}", headers: headers, params: JSON.generate(body)
    expect(response).to be_successful
    expect(Task.count).to eq(0)
    expect{ Task.find(@task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
