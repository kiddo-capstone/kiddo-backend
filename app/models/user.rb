class User < ApplicationRecord
  has_many :user_missions 
  has_many :missions, through: :user_missions 
end
