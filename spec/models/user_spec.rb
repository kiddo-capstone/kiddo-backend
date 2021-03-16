require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many(:missions)}
  end
  
  describe 'instance_methods' do
    it 'set_defaults' do
      user = create(:user)
      expect(user.points).to eq(0)
    end
  end
end
