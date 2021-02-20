require 'rails_helper'

RSpec.describe Mission, type: :model do
  describe 'relationships' do
    it {should have_many :mission_tasks}
    it {should have_many(:tasks).through(:mission_tasks)}
    it {should belong_to(:user)}
  end
end
