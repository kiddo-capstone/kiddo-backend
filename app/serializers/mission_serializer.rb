class MissionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :due_date, :user_id, :created_at, :updated_at
end
