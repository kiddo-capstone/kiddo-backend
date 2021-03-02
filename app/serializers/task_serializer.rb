class TaskSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :description, :category, :points, :photo,
             :resource_alt, :resource_link, :resource_type
end
