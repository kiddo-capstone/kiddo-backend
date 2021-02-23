class Api::V1::MissionTasksController < ApplicationController
  def index
    tasks = Mission.get_tasks(params[:id])
    render json: MissionTaskListSerializer.new(tasks)
  end

  private

  def mt_params
    params.permit(:id, :mission_id, :task_id, :is_completed, :message, :image_path)
  end
end
