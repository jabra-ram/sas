# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    it 'is not valid without an email' do
      admin = FactoryBot.build(:admin)
      admin.email = nil
      expect(admin).not_to be_valid
    end
    it 'is not valid with an invalid email format' do
      admin = FactoryBot.build(:admin)
      admin.email = 'invalid_email'
      expect(admin).not_to be_valid
    end
    it 'is not valid with an invalid password length' do
      admin = FactoryBot.build(:admin)
      admin.password = '1234'
      expect(admin).not_to be_valid
    end
    it 'is not valid without password' do
      admin = FactoryBot.build(:admin, password: nil)
      admin.password = nil
      expect(admin).not_to be_valid
    end
  end
end
