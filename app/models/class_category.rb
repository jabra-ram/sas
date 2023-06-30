class ClassCategory < ApplicationRecord
  has_and_belongs_to_many :sections, join_table: 'class_sections'
  has_one :fee_structure
  has_one :age_criterium
  has_many :students 
  validates :classname, uniqueness:true, presence: true, numericality: {greater_than: 0}
  scope :order_by_name, ->{order(classname: :asc)}
end
