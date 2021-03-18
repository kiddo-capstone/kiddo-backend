class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name, :parent_id, :points
  has_many :rewards
  has_many :missions
end
