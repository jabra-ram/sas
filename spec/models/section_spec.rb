# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Section, type: :model do
  describe 'Associations' do
    it 'has and belongs to many class_categories through join table' do
      association = described_class.reflect_on_association(:class_categories)
      expect(association.macro).to eq(:has_and_belongs_to_many)
      expect(association.options[:join_table]).to eq('class_sections')
    end

    it 'has many students' do
      association = described_class.reflect_on_association(:students)
      expect(association.macro).to eq(:has_many)
    end
  end

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
      FactoryBot.create(:section)
      section2 = FactoryBot.build(:section)
      expect(section2).not_to be_valid
    end
  end
  describe 'Callbacks' do
    describe 'before_save' do
      it 'upcases the section' do
        section = FactoryBot.create(:section, section: 'a')
        expect(section.section).to eq('A')
      end
    end
  end
end
# rubocop: enable Metrics/BlockLength
