require 'rails_helper'

describe " mission tasks" do 
    it 'can update a mission task' do 
       mission = create(:mission)
       task1, task2, task3, task4 = create_list(:task, 4)
       mission.tasks << task1
       mission.tasks << task2
       mission.tasks << task3
       mission.tasks << task4
       
       mission_task_id = mission.mission_tasks[0].id
       body = {is_completed: true, message: "Im done!!"}
       headers = {"CONTENT_TYPE" => "application/json"}
       patch "/api/v1/mission_tasks/#{mission_task_id}", headers: headers, params: body.to_json
  
       expect(response).to be_successful
       json_body = JSON.parse(response.body, symbolize_names: true)
       expect(json_body).to have_key(:message)
       expect(json_body[:message]).to eq("sucessfully updated mission task!")
    end
end 