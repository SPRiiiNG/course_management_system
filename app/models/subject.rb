class Subject
  include Mongoid::Document

  field :name,        type: String

  validates :name,
    presence: true

  belongs_to :category, class_name: 'Category'
end
