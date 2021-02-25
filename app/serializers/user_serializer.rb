class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :email, :auth_token
end
