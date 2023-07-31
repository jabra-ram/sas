# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Student, type: :model do
  describe 'Associations' do
    it 'has one attached photo' do
      association = described_class.reflect_on_association(:photo_attachment)
      expect(association.macro).to eq(:has_one)
    end

    it 'has many attached docs' do
      association = described_class.reflect_on_association(:docs_attachments)
      expect(association.macro).to eq(:has_many)
    end

    it 'belongs to a class_category' do
      association = described_class.reflect_on_association(:class_category)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to a section' do
      association = described_class.reflect_on_association(:section)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'has one payment' do
      association = described_class.reflect_on_association(:payment)
      expect(association.macro).to eq(:has_one)
    end
  end

  describe 'validations' do
    it 'is not valid without an name' do
      student = FactoryBot.build(:student)
      student.name = nil
      expect(student).not_to be_valid
    end
    it 'is not valid with name length<4' do
      student = FactoryBot.build(:student)
      student.name = 'hi'
      expect(student).not_to be_valid
    end
    it 'is not valid without invalid email' do
      student = FactoryBot.build(:student)
      student.email = 'invalid_email'
      expect(student).not_to be_valid
    end
    it 'is not valid without date of birth' do
      student = FactoryBot.build(:student)
      student.date_of_birth = nil
      expect(student).not_to be_valid
    end
    it 'is not valid without valid academic year' do
      student = FactoryBot.build(:student)
      student.academic_year = 0
      expect(student).not_to be_valid
    end
    it 'is not valid without father name' do
      student = FactoryBot.build(:student)
      student.father_name = nil
      expect(student).not_to be_valid
    end
    it 'is not valid without mother name' do
      student = FactoryBot.build(:student)
      student.mother_name = nil
      expect(student).not_to be_valid
    end
    it 'is not valid without valid contact number' do
      student = FactoryBot.build(:student)
      student.contact_number = 1234
      expect(student).not_to be_valid
    end
    it 'is not valid without contact number' do
      student = FactoryBot.build(:student)
      student.contact_number = nil
      expect(student).not_to be_valid
    end
  end
end
# rubocop: enable Metrics/BlockLength
