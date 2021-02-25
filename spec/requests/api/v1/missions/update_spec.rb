require 'rails_helper'

describe 'I can make a request to update a mission' do
  before :each do
    @user = create(:user)
    @mission = create(:mission)
    @user2 = create(:user)

    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)
    @headers = { 'CONTENT_TYPE' => 'application/json'}
    @body = {
             email: @calvin.email,
             auth_token: @calvin.auth_token
            }
  end

  it 'can update a mission name, date, or user' do
    new_due_date = Date.new(2020, 5, 16)
    new_mission_name = 'Clean the house'
    new_user_id = @user2.id
    headers = { 'CONTENT_TYPE' => 'application/json' }
    request_body = { due_date: new_due_date,
                     name: new_mission_name,
                     user_id: new_user_id,
                     email: @calvin.email,
                     auth_token: @calvin.auth_token }

    put "/api/v1/missions/#{@mission.id}", headers: headers, params: JSON.generate(request_body)
    body = JSON.parse(response.body, symbolize_names: true)
    updated_mission = Mission.find_by(id: @mission.id)
    expect(updated_mission.name).to eq(new_mission_name)
    expect(updated_mission.user_id).to eq(new_user_id)
    expect(updated_mission.due_date).to eq(new_due_date)
  end

  it 'can update a only a couple mission elements if needed' do
    new_due_date = Date.new(2020, 5, 16)
    new_mission_name = 'Clean the house'
    new_user_id = @user2.id
    headers = { 'CONTENT_TYPE' => 'application/json' }
    request_body = { due_date: new_due_date,
                     user_id: new_user_id,
                     email: @calvin.email,
                     auth_token: @calvin.auth_token  }

    patch "/api/v1/missions/#{@mission.id}", headers: headers, params: JSON.generate(request_body)
    body = JSON.parse(response.body, symbolize_names: true)
    updated_mission = Mission.find_by(id: @mission.id)
    expect(updated_mission.name).to eq(@mission.name)
    expect(updated_mission.user_id).to eq(new_user_id)
    expect(updated_mission.due_date).to eq(new_due_date)
  end

  it 'it wont update if bad data is passed' do
    new_due_date = "hello"
    new_mission_name = 'Clean the house'
    new_user_id = "5"
    headers = { 'CONTENT_TYPE' => 'application/json' }
    request_body = { due_date: new_due_date,
                     user_id: new_user_id,
                     email: @calvin.email,
                     auth_token: @calvin.auth_token  }

    patch "/api/v1/missions/#{@mission.id}", headers: headers, params: JSON.generate(request_body)
    body = JSON.parse(response.body, symbolize_names: true)
    updated_mission = Mission.find_by(id: @mission.id)
    expect(body[:data]).to have_key(:errors)
    expect(updated_mission.name).to eq(@mission.name)
    expect(updated_mission.user_id).to eq(@mission.user_id)
    expect(updated_mission.due_date).to eq(@mission.due_date)
  end
end
