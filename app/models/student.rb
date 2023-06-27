class Student < ApplicationRecord
  has_one_attached :photo
  has_many_attached :docs
end
