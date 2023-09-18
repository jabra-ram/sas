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
  describe '.exist_for_class_category' do
    let!(:class_category1) { FactoryBot.create(:class_category, classname: '1') }
    let!(:class_category2) { FactoryBot.create(:class_category, classname: '2') }
    let!(:class_category3) { FactoryBot.create(:class_category, classname: '3') }
    let!(:record1) { FactoryBot.create(:age_criterium, class_category: class_category1) }
    let!(:record2) { FactoryBot.create(:age_criterium, class_category: class_category2) }

    it 'returns records with a matching class_category_id' do
      records = AgeCriterium.exist_for_class_category(class_category1.id)
      expect(records).to include(record1)
      expect(records).not_to include(record2)
    end

    it 'returns an empty relation when no records match the class_category_id' do
      records = AgeCriterium.exist_for_class_category(class_category3.id)
      expect(records).to be_empty
    end
  end
  describe '#date_range_validation' do
    let(:class_category) { FactoryBot.create(:class_category) }
    let(:age_criterium) { FactoryBot.build(:age_criterium, class_category:) }

    context 'when date range is valid' do
      before do
        age_criterium.date_of_birth_after = '01-01-2010'
        age_criterium.date_of_birth_before = '31-12-2010'
      end

      it 'does not add an error to the age criterium' do
        expect { age_criterium.save }.not_to(change { age_criterium.errors.count })
      end
    end

    context 'when date range is not valid' do
      before do
        age_criterium.date_of_birth_after = '01-01-2012'
        age_criterium.date_of_birth_before = '31-12-2010' # End date is before start date
      end

      it 'adds an error to the age criterium' do
        expect { age_criterium.save }.to change {
          age_criterium.errors[:date_of_birth_before]
        }.from([]).to(['must be greater than date_of_birth_after'])
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
