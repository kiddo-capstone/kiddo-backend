require 'rails_helper'

describe 'mission create api' do
  it 'create a mission' do
    allow(Date).to receive(:today).and_return Date.new(2001, 2, 3)
    user = create(:user)

    mission = {
      name: 'Weekly chores',
      due_date: Date.today,
      user_id: user.id
    }
    expect(Mission.all.count).to eq(0)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/missions', headers: headers, params: JSON.generate(mission)
    created_mission = Mission.last
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(Mission.all.count).to eq(1)
    expect(body[:data][:attributes][:name]).to eq(created_mission.name)
    expect(body[:data][:attributes][:due_date]).to eq(created_mission.due_date.strftime('%F'))
    expect(body[:data][:attributes][:user_id]).to eq(created_mission.user_id)
  end

  it 'will not create a mission without a name' do
    allow(Date).to receive(:today).and_return Date.new(2001, 2, 3)
    user = create(:user)

    mission = {
      due_date: Date.today,
      user_id: user.id
    }
    expect(Mission.all.count).to eq(0)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/missions', headers: headers, params: JSON.generate(mission)
    expect(Mission.all.count).to eq(0)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Name can't be blank", :status=>"bad_request"}}
    expect(body).to eq(expected)
  end

  it 'will not create a mission without a due date' do
    allow(Date).to receive(:today).and_return Date.new(2001, 2, 3)
    user = create(:user)

    mission = {
      name: "My chore list",
      user_id: user.id
    }
    expect(Mission.all.count).to eq(0)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/missions', headers: headers, params: JSON.generate(mission)
    expect(Mission.all.count).to eq(0)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Due date can't be blank", :status=>"bad_request"}}
    expect(body).to eq(expected)
  end
  it 'will not create a mission with an invalid or nonexistant user_id' do
    allow(Date).to receive(:today).and_return Date.new(2001, 2, 3)

    mission1 = {
      name: "My chore list",
      due_date: Date.today
    }
    mission2 = {
      name: "My chore list",
      due_date: Date.today,
      user_id: 2
    }
    expect(Mission.all.count).to eq(0)
    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/missions', headers: headers, params: JSON.generate(mission1)
    expect(Mission.all.count).to eq(0)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"User must exist and User can't be blank", :status=>"bad_request"}}
    expect(body).to eq(expected)

    headers = { 'CONTENT_TYPE' => 'application/json' }
    post '/api/v1/missions', headers: headers, params: JSON.generate(mission2)
    expect(Mission.all.count).to eq(0)
    expect(response.status).to eq(400)
    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"User must exist", :status=>"bad_request"}}
    expect(body).to eq(expected)
  end
end
