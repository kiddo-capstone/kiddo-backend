class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :category, :points, :photo
end
