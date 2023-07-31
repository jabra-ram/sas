# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe AgeCriterium, type: :model do
  describe 'Associations' do
    it 'belongs to a class_category' do
      association = described_class.reflect_on_association(:class_category)
      expect(association.macro).to eq(:belongs_to)
    end
  end
  describe 'validations' do
    it 'is not valid without date_of_birth_after' do
      age_criteria = FactoryBot.build(:age_criterium)
      age_criteria.date_of_birth_after = nil
      expect(age_criteria).not_to be_valid
    end
    it 'is not valid without date_of_birth_before' do
      age_criteria = FactoryBot.build(:age_criterium)
      age_criteria.date_of_birth_before = nil
      expect(age_criteria).not_to be_valid
    end
    it 'is not valid without date_as_on' do
      age_criteria = FactoryBot.build(:age_criterium)
      age_criteria.date_as_on = nil
      expect(age_criteria).not_to be_valid
    end
    it 'is not valid without age' do
      age_criteria = FactoryBot.build(:age_criterium)
      age_criteria.age = nil
      expect(age_criteria).not_to be_valid
    end
  end
end
# rubocop: enable Metrics/BlockLength
