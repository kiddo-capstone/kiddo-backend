require 'rails_helper'

RSpec.describe Mission, type: :model do
  describe 'relationships' do
    it {should have_many :mission_tasks}
    it {should have_many(:tasks).through(:mission_tasks)}
    it {should belong_to(:user)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :due_date}
    it {should validate_presence_of :user_id}
  end
end
