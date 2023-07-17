require 'rails_helper'

RSpec.describe FeeStructure, type: :model do
  describe 'validations' do
    it 'is not valid without admission fee' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.admission_fees = nil
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid with negative admission fee' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.admission_fees = -100
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid without annual admission fee' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.annual_admission_fees = nil
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid with negative annual admission fee' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.annual_admission_fees = -100
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid without caution fee' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.caution_money = nil
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid with negative caution fee' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.caution_money = -100
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid without quarterly tuition fees' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.quarterly_tuition_fees = nil
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid with negative quarterly tuition fees' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.quarterly_tuition_fees = -100
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid without id card fees' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.id_card_fees = nil
      expect(fee_structure).not_to be_valid 
    end
    it 'is not valid with negative id card fees' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.id_card_fees = -100
      expect(fee_structure).not_to be_valid 
    end
  end
end
