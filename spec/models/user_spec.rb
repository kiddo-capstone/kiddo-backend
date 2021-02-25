require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
  end

  describe 'relationships' do
    it {should have_many(:missions)}
  end

  describe "#invite" do
    it "enqueues sending the invitation" do
      allow(SendNewUserInvitationJob).to receive(:perform_later)
      user = build(:user)

      user.invite

      expect(SendNewUserInvitationJob).to have_received(:perform_later)
    end
  end
end
