class Section < ApplicationRecord
    has_many :class_categories, dependent: :destroy
end
