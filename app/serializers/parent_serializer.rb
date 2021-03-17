class ParentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email
  has_many :users
end
