require 'rails_helper'

describe 'task destroy' do
  it 'can destroy a task' do
    task = create(:task)
    expect(Task.count).to eq(1)
    delete "/api/v1/tasks/#{task.id}"
    expect(response).to be_successful
    expect(Task.count).to eq(0)
    expect{ Task.find(task.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
