class Section < ApplicationRecord
    has_and_belongs_to_many :class_categories, join_table: 'class_sections'
    validates :section, presence: true, uniqueness: true, length: {minimum:1, maximum:1, message:"Must be 1 character"}
end
