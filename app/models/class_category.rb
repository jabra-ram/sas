class ClassCategory < ApplicationRecord
  has_and_belongs_to_many :sections, join_table: 'class_sections'
  validates :classname, uniqueness:true, presence: true, numericality: {greater_than: 0}
  scope :order_by_name, ->{order(classname: :asc)}
end
