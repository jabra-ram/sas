class Student < ApplicationRecord
  has_one_attached :photo
  has_many_attached :docs
  belongs_to :class_category
  belongs_to :section
  validates :name, presence:true
  validates :email, presence:true, uniqueness:true
  validates :date_of_birth, presence:true
  validates :class_category_id, presence:true
  validates :section_id, presence:true
  validates :academic_year, presence:true
  validates :father_name, presence:true
  validates :mother_name, presence:true
  validates :address, presence:true
  validates :contact_number, presence:true
end
