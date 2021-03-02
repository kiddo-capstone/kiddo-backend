class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email, :points
end
