class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :category, :points
end
