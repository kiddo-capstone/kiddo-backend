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
end
