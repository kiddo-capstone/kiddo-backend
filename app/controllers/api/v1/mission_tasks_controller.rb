class Api::V1::MissionTasksController < ApplicationController
  def index
    tasks = Mission.find(params[:id])
                   .tasks
                   .select("mission_tasks.id,
                            mission_tasks.mission_id,
                            mission_tasks.task_id,
                            mission_tasks.message,
                            mission_tasks.image_path,
                            tasks.name as task_name,
                            tasks.description as task_description,
                            tasks.category as task_category,
                            tasks.points")
                            
    mission_tasks = { data: [] }

    tasks.map do |task|
      task_hash = JSON.parse(task.to_json, symbolize_names: true)
      mission_tasks[:data] << { id: task_hash[:id],
                                type: 'mission_task',
                                attributes: task_hash }
    end
    render json: mission_tasks
  end
end
