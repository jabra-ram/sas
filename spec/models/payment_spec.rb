# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment, type: :model do
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
    it 'is not valid with invalid amount' do
      payment = FactoryBot.build(:payment)
      payment.amount = -100
      expect(payment).not_to be_valid
    end
  end
end
