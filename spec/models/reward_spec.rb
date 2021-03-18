require 'rails_helper'

RSpec.describe Reward, type: :model do
  describe "validations" do
    it {should validate_presence_of :title}
    it {should validate_presence_of :points_to_redeem}
  end

  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :parent}
  end

  describe 'instance methods' do
    before :each do
      @reward = create(:reward)
    end

    it 'self.set_defaults' do
      expect(@reward.redeemed).to eq(false)
    end
  end
end
