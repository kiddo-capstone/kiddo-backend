class Api::V1::MissionTasksController < ApplicationController

 
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
      mission_task.update(mission_task_params)
      render json: { message: 'sucessfully updated mission task!' }
    else 
      errors = "mission task does not exist."
      json_errors(errors, :bad_request)
    end
  end 


  private 

  def mission_task_params
    params.permit(:is_completed, :message, :mission_id, :task_id, :image_path)
  end 
end
