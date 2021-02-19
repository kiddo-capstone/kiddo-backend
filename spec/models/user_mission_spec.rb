require 'rails_helper'

RSpec.describe UserMission, type: :model do
  describe 'relationships' do
    it {should belong_to :mission}
    it {should belong_to :user}
  end
end
