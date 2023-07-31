# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Payment, type: :model do
  describe 'Associations' do
    it 'belongs to a student' do
      association = described_class.reflect_on_association(:student)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'is not valid without student id' do
      payment = FactoryBot.build(:payment)
      payment.student_id = nil
      expect(payment).not_to be_valid
    end
    it 'is not valid with invalid student id' do
      payment = FactoryBot.build(:payment)
      payment.student_id = -3
      expect(payment).not_to be_valid
    end
    it 'is not valid without mode of payment' do
      payment = FactoryBot.build(:payment)
      payment.mode_of_payment = nil
      expect(payment).not_to be_valid
    end
    it 'is not valid without amount' do
      payment = FactoryBot.build(:payment)
      payment.amount = nil
      expect(payment).not_to be_valid
    end
    it 'is not valid with invalid amount' do
      payment = FactoryBot.build(:payment)
      payment.amount = -100
      expect(payment).not_to be_valid
    end
  end
end
# rubocop: enable Metrics/BlockLength
