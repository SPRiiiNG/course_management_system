class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  #Fields
  field :first_name,              type: String
  field :last_name,               type: String
  field :nickname,                type: String
  field :birthday,                type: DateTime
  field :gender,                  type: String, default: 'male'
  field :instructor,              type: Boolean, default: false

  #Validations
  validates_presence_of :first_name, :last_name, :nickname
  validates_inclusion_of :gender, :in => %w( male female ), :message => "extension %s is not included in the list"

  has_many :courses, class_name: 'Course'

  def add_course(course)
    errors.add(:base, :invalid, message: "student can't create course") and (return false) unless self.instructor
    self.courses << course
  end

  def remove_course(course)
    self.courses.find(course).destroy rescue nil
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
