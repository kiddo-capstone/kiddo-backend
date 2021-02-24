class MissionTaskListSerializer
  def self.new(tasks)
    mission_tasks = { data: [] }

    tasks.each do |task|
      htask = JSON.parse(task.to_json, symbolize_names: true)
      mt_id = htask[:id]
      htask.delete(:id)
      ntask = { id: mt_id,
                type: 'mission_task',
                attributes: htask }
      mission_tasks[:data] << ntask
    end
    mission_tasks
  end
end
