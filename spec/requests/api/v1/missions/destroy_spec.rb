require 'rails_helper'

describe 'mission destroy api' do
  before(:each) do
    @calvin = User.create(name: 'Calvin',
                          email: 'Calvin@example.com',
                          auth_token: SecureRandom.uuid)
    @headers = { 'CONTENT_TYPE' => 'application/json'}
    @body = {
             email: @calvin.email,
             auth_token: @calvin.auth_token
            }
  end

  it 'can destroy a mission' do
    mission = create(:mission)
    expect(Mission.all.count).to eq(1)
    delete "/api/v1/missions/#{mission.id}", headers: @headers, params: JSON.generate(@body)
    expect(response).to be_successful
    body = JSON.parse(response.body, symbolize_names: true)
    expect(Mission.all.count).to eq(0)
    expect(body[:data][:attributes][:name]).to eq(mission.name)
    expect(body[:data][:attributes][:due_date]).to eq(mission.due_date.strftime("%F"))
    expect(body[:data][:attributes][:user_id]).to eq(mission.user_id)
    expect{ Mission.find(mission.id) }.to raise_error(ActiveRecord::RecordNotFound)
  end
  it "it cannot destroy mission if it can't find it" do

    expect(Mission.all.count).to eq(0)
    delete "/api/v1/missions/2", headers: @headers, params: JSON.generate(@body)
    expect(response.status).to eq(400)
    expect(Mission.all.count).to eq(0)
    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Unable to destroy mission.", :status=>"bad_request"}}
    expect(body).to eq(expected)
  end
end
