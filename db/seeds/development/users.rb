puts "Generating Users..."

student = {
  email: 'student-1@example.com',
  password: '123456',
  password_confirmation: '123456',
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  nickname: Faker::Pokemon.name,
  birthday: Faker::Date.between(30.years.ago, 15.years.ago),
  gender: ['male', 'female'].sample,
  instructor: false
}
User.create(student)

(1..5).each do |i|
  instructor = {
    email: "instructor-#{i}@example.com",
    password: '123456',
    password_confirmation: '123456',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nickname: Faker::Pokemon.name,
    birthday: Faker::Date.between(30.years.ago, 15.years.ago),
    gender: ['male', 'female'].sample,
    instructor: true
  }
  User.create(instructor)
end
