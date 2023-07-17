class Student < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_one_attached :photo
  has_many_attached :docs
  belongs_to :class_category
  belongs_to :section
  validates :name, presence:{message: 'name cannot be null'}, length:{minimum:4, message:'name should be minimum 4 characters'}
  validates :email, presence:{message: 'email cannot be null'}, uniqueness:{message: 'email is already taken'}
  validates :date_of_birth, presence:{message:'enter valid date'}
  validates :class_category_id, presence:true
  validates :section_id, presence:true
  validates :academic_year, presence:{message: 'year cannot be null'}, 
                            numericality:{greater_than:2011, less_than_or_equal_to:Date.today.year, message:'enter a valid year'}
  validates :father_name, presence:{message: 'father name cannot be null'}
  validates :mother_name, presence:{message: 'mother cannot be null'}
  validates :address, presence:{message: 'address cannot be null'}
  validates :contact_number,  presence:{message: 'contact number cannot be null'},
                              length:{minimum:8, maximum:10, message:'enter valid number'}
  validates :photo, presence:{message:'upload profile picture'}

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
      indexes :name_sort, type: :keyword
      indexes :email_sort, type: :keyword
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
      section: section.section,
      name_sort: name,
      email_sort: email
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
      if sort_by == "name"
        sort_field = "name_sort"
      elsif sort_by == "email"
        sort_field = "email_sort"
      else
        sort_field = sort_by
      end
      search_params[:sort] = {
        sort_field.to_sym => {
          order: :asc
        }
      }
    end

    search(search_params)
  end
  index_data
end
