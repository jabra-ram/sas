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
  describe '#valid_age_for_class' do
    let(:class_category) { FactoryBot.create(:class_category) }
    let(:age_criterium) { FactoryBot.create(:age_criterium, class_category:) }
    let(:student) { FactoryBot.build(:student, class_category:) }

    context 'when age criteria exist and allow admission' do
      before do
        age_criterium.update(date_of_birth_after: '01-01-2010', date_of_birth_before: '31-12-2010')
        student.date_of_birth = '15-06-2010' # Age 10, within criteria
      end

      it 'does not add an error' do
        expect { student.save }.not_to(change { student.errors.count })
      end
    end

    context 'when age criteria exist but disallow admission' do
      before do
        age_criterium.update(date_of_birth_after: '01-01-2010', date_of_birth_before: '31-12-2010')
        student.date_of_birth = '15-06-2008' # Age 12, outside criteria
      end

      it 'adds an error to the student' do
        expect { student.save }.to change {
          student.errors[:base]
        }.from([]).to(['The age criteria for the class does not allow the student to be admitted!'])
      end
    end

    context 'when age criteria do not exist' do
      it 'adds an error to the student' do
        expect { student.save }.to change {
          student.errors[:base]
        }.from([]).to(
          ['please add age criteria for the class, without age criteria the required age cannot be determined!']
        )
      end
    end
  end
  describe '.index_data' do
    it 'creates the Elasticsearch index and imports data' do
      expect(Student.__elasticsearch__).to receive(:create_index!).with(force: true)
      expect(Student.__elasticsearch__).to receive(:import)

      Student.index_data
    end
  end

  describe '#search_query' do
    let(:student1) { FactoryBot.build(:student) }

    before do
      Student.__elasticsearch__.create_index! force: true
      Student.import
    end

    it 'returns the matching records' do
      expect(Student).to receive(:search).and_return([student1])

      result = Student.search_query('John')
      expect(result).to eq([student1])
    end

    it 'returns an empty array for no matching records' do
      expect(Student).to receive(:search).and_return([])

      result = Student.search_query('Nonexistent')
      expect(result).to eq([])
    end
  end

  describe '.as_indexed_json' do
    it 'returns the indexed JSON representation' do
      student = FactoryBot.build(:student)

      indexed_json = student.as_indexed_json

      expect(indexed_json).to have_key(:name)
      expect(indexed_json[:name]).to eq('mohit verma')
      expect(indexed_json).to have_key(:email)
      expect(indexed_json[:email]).to eq('mohit@gmail.com')
      expect(indexed_json).to have_key(:date_of_birth)
      expect(indexed_json[:date_of_birth]).to eq(Date.parse('02-03-2016'))
      expect(indexed_json).to have_key(:academic_year)
      expect(indexed_json[:academic_year]).to eq(2023)
      expect(indexed_json).to have_key(:father_name)
      expect(indexed_json[:father_name]).to eq('rajesh verma')
      expect(indexed_json).to have_key(:mother_name)
      expect(indexed_json[:mother_name]).to eq('menka verma')
      expect(indexed_json).to have_key(:address)
      expect(indexed_json[:address]).to eq('kolkata')
    end
  end
end
# rubocop: enable Metrics/BlockLength
