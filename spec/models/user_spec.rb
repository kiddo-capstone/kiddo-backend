require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should have_secure_password}
    it {should validate_presence_of :name}
    it {should validate_uniqueness_of :name}
  end

  describe 'relationships' do
    it {should have_many :user_missions}
    it {should have_many(:missions).through(:user_missions)}
  end
end
