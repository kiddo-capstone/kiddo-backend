
class Api::V1::MissionTasksController < ApplicationController
  
  def show
    json_create(MissionTask.find(params[:id]))
  end

  def create 
    mission_task = MissionTask.new(mission_task_params)
    if mission_task.save
      json_create(mission_task)
    else 
      errors = mission_task.errors.full_messages.to_sentence
      json_errors(errors, :bad_request)
    end
  end 


  def index
    tasks = Mission.get_tasks(params[:id])
    if tasks
      render json: MissionTaskListSerializer.new(tasks)
    else
      errors = "mission does not exist."
      json_errors(errors, :bad_request)
    end
  end

  def update 
    mission_task = MissionTask.find_by(id: params[:id])
    if mission_task 
      require 'pry'; binding.pry
      mission_task.update(mission_task_params)
      
      #the path of the uploaded file is:
      url = "https://wills-bucket.s3-us-west-2.amazonaws.com/#{mission_task.image.key}"

      #to retrieve the actual file and store locally:
      client = Aws::S3::Client.new(region: 'us-west-2')
      client.get_object({ bucket:'wills-bucket', key: mission_task.image.key }, target: 'test.png')
      
      render json: { message: 'sucessfully updated mission task!' }
    else 
      errors = "mission task does not exist."
      json_errors(errors, :bad_request)
    end
  end 

  def destroy
    MissionTask.destroy(params[:id])
  end 


  private 

  def json_create(mission_task)
    render json: MissionTaskSerializer.new(mission_task)
  end

  private

  
  def mission_task_params
    params.permit(:is_completed, :message, :mission_id, :task_id, :image_path, :image)
  end

  
end
