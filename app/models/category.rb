class Category
  include Mongoid::Document

  field :name,        type: String

  validates :name,
    presence: true

  has_many :subjects, class_name: 'Subject'

  def add_subject(subject)
    self.subjects << subject
  end

  def remove_subject(subject)
    self.subjects.find(subject).destroy rescue nil
  end
end
