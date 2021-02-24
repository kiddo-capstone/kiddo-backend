class MissionTaskSerializer
  include FastJsonapi::ObjectSerializer
  attributes :is_completed, :message, :mission_id, :task_id, :image_path
end
