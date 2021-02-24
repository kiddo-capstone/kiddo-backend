require 'rails_helper'

describe 'we can see details of specific mission' do
  it 'can send a json of a specific mission' do
    user = create(:user)
    mission = create(:mission)

    get "/api/v1/missions/#{mission.id}"
    body = JSON.parse(response.body, symbolize_names: true)
    expect(body[:data][:id]).to eq(mission.id.to_s)
    expect(body[:data][:type]).to eq("mission")
    expect(body[:data][:attributes][:name]).to eq(mission.name)
    expect(body[:data][:attributes][:due_date].to_date.strftime("%F")).to eq(mission.due_date.to_date.strftime("%F"))
    expect(body[:data][:attributes][:user_id]).to eq(mission.user_id)
    expect(body[:data][:attributes][:created_at].to_date.strftime("%F")).to eq(mission.created_at.to_date.strftime("%F"))
    expect(body[:data][:attributes][:updated_at].to_date.strftime("%F")).to eq(mission.updated_at.to_date.strftime("%F"))
  end

  it 'will send an error if mission cant be found' do

    get "/api/v1/missions/3"
    body = JSON.parse(response.body, symbolize_names: true)
    expected = {:data=>{:errors=>"Unable to find mission", :status=>"bad_request"}}
    expect(body).to eq(expected)
  end
end