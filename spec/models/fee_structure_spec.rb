# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe FeeStructure, type: :model do
  describe 'Associations' do
    it 'belongs to a class_category' do
      association = described_class.reflect_on_association(:class_category)
      expect(association.macro).to eq(:belongs_to)
    end
  end
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
    it 'is not valid without total' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.total = nil
      expect(fee_structure).not_to be_valid
    end
    it 'is not valid with negative total' do
      fee_structure = FactoryBot.build(:fee_structure)
      fee_structure.total = -100
      expect(fee_structure).not_to be_valid
    end
  end
  describe '.exist_for_class_category' do
    let!(:class_category1) { FactoryBot.create(:class_category, classname: '1') }
    let!(:class_category2) { FactoryBot.create(:class_category, classname: '2') }
    let!(:class_category3) { FactoryBot.create(:class_category, classname: '3') }
    let!(:record1) { FactoryBot.create(:fee_structure, class_category: class_category1) }
    let!(:record2) { FactoryBot.create(:fee_structure, class_category: class_category2) }

    it 'returns records with a matching class_category_id' do
      records = FeeStructure.exist_for_class_category(class_category1.id)
      expect(records).to include(record1)
      expect(records).not_to include(record2)
    end

    it 'returns an empty relation when no records match the class_category_id' do
      records = FeeStructure.exist_for_class_category(class_category3.id)
      expect(records).to be_empty
    end
  end
end
# rubocop:enable Metrics/BlockLength
