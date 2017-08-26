puts "Generating Courses..."

subjects = Subject.all.map(&:id)

User.where(instructor: true).each do |instuctor|
  (1..3).each do
    start_time = (Faker::Time.between(DateTime.now - 5.hours, DateTime.now + 5.hours)).change({ min: 0, sec: 0 })
    course = Course.new(
      name: Faker::Educator.course,
      description: 'course description',
      start_time: start_time,
      end_time: start_time + [1, 2, 3].sample.hours,
      capacity: [20, 30, 40, 50].sample,
      subject: subjects.sample
    )
    instuctor.add_course(course) rescue next
  end
end
