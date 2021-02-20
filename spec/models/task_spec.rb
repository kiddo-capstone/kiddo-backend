require 'rails_helper'

RSpec.describe Task, type: :model do
    describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :category}
    it {should validate_numericality_of :points}
  end

  describe 'relationships' do
    it {should have_many :mission_tasks}
    it {should have_many(:missions).through(:mission_tasks)}
  end
end
