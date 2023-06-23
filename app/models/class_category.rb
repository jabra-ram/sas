class ClassCategory < ApplicationRecord
  belongs_to :section
  validates :classname, presence: true, numericality: {greater_than: 0}

  scope :order_by_name, ->{order(classname: :asc)}
end
