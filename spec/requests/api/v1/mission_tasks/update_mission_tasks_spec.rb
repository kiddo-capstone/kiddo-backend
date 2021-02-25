require 'rails_helper'

describe " mission tasks" do
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

    it 'can update a mission task' do
       mission = create(:mission)
       task1 = create(:task)
       mission.tasks << task1
       mission_task = mission.mission_tasks[0]
       body = {is_completed: true, message: "Im done!!", email: @calvin.email, auth_token: @calvin.auth_token}
       headers = {"CONTENT_TYPE" => "application/json"}
       patch "/api/v1/mission_tasks/#{mission_task.id}", headers: headers, params: body.to_json
       expect(response).to be_successful
       json_body = JSON.parse(response.body, symbolize_names: true)
       expect(json_body).to have_key(:message)
       expect(json_body[:message]).to eq("sucessfully updated mission task!")
       mission_task.reload
       expect(mission_task.message).to eq("Im done!!")
       expect(mission_task.is_completed).to eq(true)
    end

    it 'gets error message when cant find mission task' do
       mission = create(:mission)
       task1 = create(:task)
       mission.tasks << task1
       mission_task = mission.mission_tasks[700]
       body = {is_completed: true, message: 123123, email: @calvin.email, auth_token: @calvin.auth_token}
       headers = {"CONTENT_TYPE" => "application/json"}
       patch "/api/v1/mission_tasks/700", headers: headers, params: body.to_json
       expect(response).to_not be_successful
       json_body = JSON.parse(response.body, symbolize_names: true)
       expect(json_body).to have_key(:data )
       expect(json_body[:data]).to have_key(:errors )
       expect(json_body[:data][:errors]).to eq("mission task does not exist.")
    end
end
