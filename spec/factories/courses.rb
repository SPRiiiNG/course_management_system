FactoryGirl.define do
  factory :course do
    name            { Faker::Educator.course }
    description     { 'course description'}
    start_time      { Faker::Time.between(DateTime.now - 5.hours, DateTime.now + 5.hours) }
    end_time        { start_time + 3.hours }
    capacity        { [20, 30, 40, 50].sample }
  end
end
