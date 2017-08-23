FactoryGirl.define do

  factory :user do
    first_name              { Faker::Name.first_name }
    last_name               { Faker::Name.last_name }
    nickname                { Faker::Pokemon.name }
    birthday                { Faker::Date.between(30.years.ago, 15.years.ago) }
    gender                  { ['male', 'female'].sample }
    instructor              { false }
    email                   { "#{last_name}.#{first_name}@example.com" }
    password                { '123456' }
    password_confirmation   { password }
  end
end
