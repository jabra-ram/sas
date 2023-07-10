class Student < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

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

  def self.index_data
    __elasticsearch__.create_index! force: true
    __elasticsearch__.import
  end
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :name, type: :text, analyzer: :english, fielddata: :true
      indexes :email, type: :text, analyzer: :english, fielddata: :true
      indexes :academic_year, type: :text, analyzer: :english, fielddata: :true
      indexes :address, type: :text, analyzer: :english
      indexes :father_name, type: :text, analyzer: :english, fielddata: :true
      indexes :mother_name, type: :text, analyzer: :english
      indexes :contact_number, type: :text, analyzer: :english
      indexes :classname, type: :keyword
      indexes :section, type: :keyword

    end
  end
  def as_indexed_json(_options = {})
    {
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
      section: section.section
    }
  end
  def self.search_query(query, filter_column, filter_value, sort_by)
    search_params = {
      query: {
        bool: {
          must: [
            {
              multi_match: {
                query: query,
                fields: [:name, :email, :address, :academic_year, :father_name, :mother_name, :contact_number]
              }
            }
          ]
        }
      }
    }
  
    if !filter_column.empty? && !filter_value.empty?
      search_params[:query][:bool][:filter] = {
        term: {
          filter_column.to_sym => filter_value
        }
      }
    end
  
    if sort_by && !sort_by.empty?
      search_params[:sort] = {
        sort_by.to_sym => {
          order: :asc
        }
      }
    end
    puts search_params
    search(search_params)
  end
  
  index_data
end
