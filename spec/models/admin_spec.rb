# frozen_string_literal: true

require 'rails_helper'

# rubocop: disable Metrics/BlockLength
RSpec.describe Admin, type: :model do
  describe 'associations' do
    it 'has many notifications with foreign key "recipient_id"' do
      association = described_class.reflect_on_association(:notifications)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('recipient_id')
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
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
  describe 'Callbacks' do
    it 'converts email to lowercase before saving' do
      admin = FactoryBot.build(:admin, email: 'TEST@example.com')
      admin.save
      expect(admin.email).to eq('test@example.com')
    end
  end
end
# rubocop: enable Metrics/BlockLength
