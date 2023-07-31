# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe ClassCategory, type: :model do
  describe 'Associations' do
    it 'has and belongs to many sections with join table "class_sections"' do
      association = described_class.reflect_on_association(:sections)
      expect(association.macro).to eq(:has_and_belongs_to_many)
      expect(association.options[:join_table]).to eq('class_sections')
    end

    it 'has one fee_structure with dependent destroy' do
      association = described_class.reflect_on_association(:fee_structure)
      expect(association.macro).to eq(:has_one)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has one age_criterium with dependent destroy' do
      association = described_class.reflect_on_association(:age_criterium)
      expect(association.macro).to eq(:has_one)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it 'has many students with dependent destroy' do
      association = described_class.reflect_on_association(:students)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end

  describe 'validations' do
    it 'is not valid without class name' do
      class_category = FactoryBot.build(:class_category)
      class_category.classname = nil
      expect(class_category).not_to be_valid
    end

    it 'is not valid with a duplicate class name' do
      FactoryBot.create(:class_category, classname: '1')
      class_category2 = FactoryBot.build(:class_category, classname: '1')
      expect(class_category2).not_to be_valid
    end

    it 'is not valid with a non-numeric class name' do
      class_category = FactoryBot.build(:class_category, classname: 'A')
      expect(class_category).not_to be_valid
    end

    it 'is not valid with a class name less than 1' do
      class_category = FactoryBot.build(:class_category, classname: 0)
      expect(class_category).not_to be_valid
    end

    it 'is not valid with a class name greater than 12' do
      class_category = FactoryBot.build(:class_category, classname: 13)
      expect(class_category).not_to be_valid
    end
  end

  describe 'scope - order_by_name' do
    it 'orders class categories by name in ascending order' do
      class_category1 = FactoryBot.create(:class_category, classname: '3')
      class_category2 = FactoryBot.create(:class_category, classname: '1')
      class_category3 = FactoryBot.create(:class_category, classname: '2')

      expect(ClassCategory.order_by_name).to eq([class_category2, class_category3, class_category1])
    end
  end
end
# rubocop: enable Metrics/BlockLength
