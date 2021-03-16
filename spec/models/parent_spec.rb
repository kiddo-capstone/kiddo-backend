require 'rails_helper'

RSpec.describe Parent, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'relationships' do
    it { should have_many(:users) }
  end
end
