require 'rails_helper'

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
    it 'is not valid with duplicate email' do
      invitation = FactoryBot.create(:invitation)
      invitation2 = FactoryBot.build(:invitation)
      expect(invitation2).not_to be_valid 
    end
    it 'is not valid without expiry date' do
      invitation = FactoryBot.build(:invitation)
      invitation.expires_at = nil
      expect(invitation).not_to be_valid 
    end
    it 'is not valid without unique token date' do
      invitation = FactoryBot.build(:invitation)
      invitation.token = nil
      expect(invitation).not_to be_valid 
    end
  end
end
