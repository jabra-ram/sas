# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'Associations' do
    it 'belongs to a recipient with class_name Admin' do
      association = described_class.reflect_on_association(:recipient)
      expect(association.macro).to eq(:belongs_to)
      expect(association.options[:class_name]).to eq('Admin')
    end
  end

  describe 'Scopes' do
    describe '.unread' do
      it 'returns notifications with read_status false' do
        admin = FactoryBot.create(:admin)
        unread_notification = FactoryBot.create(:notification, recipient: admin, read_status: false)
        read_notification = FactoryBot.create(:notification, recipient: admin, read_status: true)

        expect(described_class.unread).to include(unread_notification)
        expect(described_class.unread).not_to include(read_notification)
      end
    end
  end
end
