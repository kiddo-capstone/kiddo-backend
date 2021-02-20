require 'rails_helper'

RSpec.describe MissionTask, type: :model do
  describe 'relationships' do
    it {should belong_to :mission}
    it {should belong_to :task}
  end
end
