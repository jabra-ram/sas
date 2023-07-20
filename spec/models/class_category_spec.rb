# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClassCategory, type: :model do
  describe 'validations' do
    it 'is not valid without class name' do
      class_category = FactoryBot.build(:class_category)
      class_category.classname = nil
      expect(class_category).not_to be_valid
    end
  end
end
