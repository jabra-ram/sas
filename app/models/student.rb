# frozen_string_literal: true

# This is student model
class Student < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_one_attached :photo
  has_many_attached :docs
  belongs_to :class_category
  belongs_to :section
  has_one :payment, dependent: :destroy

  validates :name, presence: { message: 'name cannot be null' },
                   length: { minimum: 4, message: 'name should be minimum 4 characters' }
  validates :email, presence: { message: 'email cannot be null' },
                    format: { with: /\A[A-Za-z0-9]+[._-]{0,1}[a-zA-Z0-9]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                              message: 'invalid email' },
                    uniqueness: { message: 'email is already taken' }
  validates :date_of_birth, presence: { message: 'enter valid date' }
  validates :age, presence: true, numericality: { greater_than: 3, message: 'must be greater than 3' }
  validates :academic_year, presence: { message: 'year cannot be null' },
                            numericality: { greater_than: 2011, less_than_or_equal_to: Date.today.year,
                                            message: 'enter a valid year' }
  validates :father_name, presence: { message: 'father name cannot be null' }
  validates :mother_name, presence: { message: 'mother cannot be null' }
  validates :address, presence: { message: 'address cannot be null' }
  validates :contact_number,  presence: { message: 'contact number cannot be null' },
                              length: { minimum: 8, maximum: 10, message: 'enter valid number' },
                              numericality: { greater_than: 0, message: 'enter a valid  number' }
  before_save :valid_age_for_class

  def valid_age_for_class
    unless class_category&.age_criterium
      errors.add(:base,
                 'please add age criteria for the class, without age criteria the required age cannot be determined!')
      throw(:abort)
    end
    age_criteria = class_category.age_criterium
    return if age_criteria.date_of_birth_after <= date_of_birth && age_criteria.date_of_birth_before >= date_of_birth

    errors.add(:base, 'The age criteria for the class does not allow the student to be admitted!')
    throw(:abort)
  end

  def self.index_data
    __elasticsearch__.create_index! force: true
    __elasticsearch__.import
  end
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :id, type: :text
      indexes :date_of_birth, type: :keyword
      indexes :name, type: :text, analyzer: :english, fielddata: true
      indexes :email, type: :text, analyzer: :english, fielddata: true
      indexes :academic_year, type: :text, analyzer: :english, fielddata: true
      indexes :age, type: :text
      indexes :address, type: :text, analyzer: :english
      indexes :father_name, type: :text, analyzer: :english, fielddata: true
      indexes :mother_name, type: :text, analyzer: :english
      indexes :contact_number, type: :text, analyzer: :english
      indexes :classname, type: :keyword
      indexes :section, type: :keyword
      indexes :name_sort, type: :keyword
      indexes :email_sort, type: :keyword
    end
  end
  # rubocop:disable all
  def as_indexed_json(_options = {})
    {
      id: id,
      name: name,
      email: email,
      academic_year: academic_year,
      address: address,
      date_of_birth: date_of_birth,
      age: age,
      class_category_id: class_category_id,
      section_id: section_id,
      father_name: father_name,
      mother_name: mother_name,
      contact_number: contact_number,
      classname: class_category.classname,
      section: section.section,
      name_sort: name,
      email_sort: email
    }
  end

  def self.search_query(query)
    search_params = {
      query: {
        bool: {
          must: [
            {
              multi_match: {
                query:,
                fields: %i[id name email date_of_birth address age academic_year classname father_name mother_name contact_number]
              }
            }
          ]
        }
      }
    }
    search(search_params)
  end
  index_data
end
# rubocop:enable Metrics/MethodLength,Style/HashSyntax
