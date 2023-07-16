class ClassCategory < ApplicationRecord
  has_and_belongs_to_many :sections, join_table: 'class_sections'
  has_one :fee_structure, dependent: :destroy
  has_one :age_criterium, dependent: :destroy
  has_many :students, dependent: :destroy
  validates :classname, uniqueness:{message: 'Class already exists'}, 
                        presence: {message: "Class can't be null"}, 
                        numericality: {greater_than: 0, less_than: 13, message:'Enter a valid class(1-12)'}
  scope :order_by_name, ->{order(classname: :asc)}
end
