class Api::V1::MissionTasksController < ApplicationController
  def index
    tasks = Mission.get_tasks(params[:id])
    render json: MissionTaskListSerializer.new(tasks)
  end
end
