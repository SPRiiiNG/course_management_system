class Course
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,          type: String
  field :description,   type: String
  field :start_time,    type: DateTime
  field :end_time,      type: DateTime
  field :capacity,      type: Integer

  belongs_to :subject, class_name: 'Subject', inverse_of: :course
  belongs_to :user, class_name: 'User'
end
