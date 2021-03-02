require 'rails_helper'

describe 'user destroy api' do
  it 'can destroy a user' do
    user = create(:user)
    expect(User.count).to eq(1)
    delete "/api/v1/users/#{user.id}"
    expect(response).to be_successful
    expect(User.count).to eq(0)
    expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end


  it 'can destroy a user when they have missions and tasks' do
    user = create(:user)
    mission = create(:mission, user_id: user.id)
    task = create(:task)
    mission.tasks << task
    expect(User.count).to eq(1)
    delete "/api/v1/users/#{user.id}"
    expect(response).to be_successful
    expect(User.count).to eq(0)
    expect{ User.find(user.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'sends an error json when tryign to destroy an invalid user' do
    
    delete "/api/v1/users/17"
    expect(response.status).to eq(400)
    response_body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Unable to destroy user.", :status=>"bad_request"}}
    expect(expected).to eq(response_body)
  end
end
