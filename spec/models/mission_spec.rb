require 'rails_helper'

RSpec.describe Mission, type: :model do
  describe 'relationships' do
    it {should have_many :mission_tasks}
    it {should have_many :user_missions}
    it {should have_many(:tasks).through(:mission_tasks)}
    it {should have_many(:users).through(:user_missions)}
  end
end
