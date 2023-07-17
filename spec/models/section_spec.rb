require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'validations' do
    it 'is not valid without section name' do
      section = FactoryBot.build(:section)
      section.section = nil
      expect(section).not_to be_valid 
    end
    it 'is not valid with invalid section name' do
      section = FactoryBot.build(:section)
      section.section = '90'
      expect(section).not_to be_valid 
    end
    it 'is not valid with duplicate section' do
      section = FactoryBot.create(:section)
      section2 = FactoryBot.build(:section)
      expect(section2).not_to be_valid 
    end
  end
end
