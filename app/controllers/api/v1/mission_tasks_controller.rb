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
      errors = 'mission does not exist.'
      json_errors(errors, :bad_request)
    end
  end

  def update
    mission_task = MissionTask.find_by(id: params[:id])
    changing_completion = changing_completion?(mission_task)

    if mission_task&.update(mission_task_params)
      point_adjustment(mission_task) if changing_completion
      json_create(mission_task)
    else
      errors = 'mission task does not exist.'
      json_errors(errors, :bad_request)
    end
  end

  def destroy
    MissionTask.destroy(params[:id])
  end

  private

  def mission_task_params
    params.permit(:is_completed, :message, :mission_id, :task_id, :image_path, :image)
  end

  def json_create(mission_task)
    render json: MissionTaskSerializer.new(mission_task)
  end


  def changing_completion?(mission_task)
    return false if mission_task.nil?
    return false unless params.include?(:is_completed)

    mission_task.is_completed != params[:is_completed]
  end

  def point_adjustment(mission_task)
    new_is_completed = params[:is_completed]
    mission_task.adjust_points(new_is_completed)
  end
end
