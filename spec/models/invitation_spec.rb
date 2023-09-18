# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Metrics/BlockLength
RSpec.describe Invitation, type: :model do
  describe 'validations' do
    it 'is not valid without email' do
      invitation = FactoryBot.build(:invitation)
      invitation.email = nil
      expect(invitation).not_to be_valid
    end
    it 'is not valid with invalid email format' do
      invitation = FactoryBot.build(:invitation)
      invitation.email = 'invalid_email'
      expect(invitation).not_to be_valid
    end
    it 'is not valid without expiry date' do
      invitation = FactoryBot.build(:invitation)
      invitation.expires_at = nil
      expect(invitation).not_to be_valid
    end
    it 'is not valid without token' do
      invitation = FactoryBot.build(:invitation)
      invitation.token = nil
      expect(invitation).not_to be_valid
    end
  end
  describe 'Callbacks' do
    it 'converts email to lowercase before saving' do
      invitation = FactoryBot.build(:invitation, email: 'TEST@example.com')
      invitation.save
      expect(invitation.email).to eq('test@example.com')
    end
  end
  describe '#admin_exists' do
    let(:admin_email) { 'admin@example.com' }
    let(:invitation) { FactoryBot.build(:invitation, email: admin_email) }

    context 'when an admin with the same email exists' do
      before do
        FactoryBot.create(:admin, email: admin_email)
      end

      it 'adds an error to the invitation' do
        expect { invitation.save }.to change {
          invitation.errors[:email]
        }.from([]).to(['admin already exists with this email!'])
      end
    end

    context 'when an admin with the same email does not exist' do
      it 'does not add an error to the invitation' do
        expect { invitation.save }.not_to(change { invitation.errors.count })
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
