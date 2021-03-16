class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :points
end
