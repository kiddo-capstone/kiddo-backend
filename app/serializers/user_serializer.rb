class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :parent_id, :points
end
