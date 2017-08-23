require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:first_name).of_type(String) }
    it { is_expected.to have_field(:last_name).of_type(String) }
    it { is_expected.to have_field(:nickname).of_type(String) }
    it { is_expected.to have_field(:birthday).of_type(DateTime) }
    it { is_expected.to have_field(:gender).of_type(String).with_default_value_of('male') }
    it { is_expected.to have_field(:instructor).of_type(Mongoid::Boolean).with_default_value_of(false) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_inclusion_of(:gender).to_allow("male", "female") }
  end

  describe "Associations" do
    it { is_expected.to have_many(:courses).of_type(Course) }
  end

  describe "Methods" do
    let(:student)        { FactoryGirl.create(:user) }
    let(:instructor)     { FactoryGirl.create(:user, instructor: true) }
    let(:category)       { Category.create(name: "Computer") }
    let(:subject)        { Subject.new(name: "Web Programming") }
    let(:course)    { Course.new(name: "Course 1", subject: subject, start_time: DateTime.now + 5.hours, end_time: DateTime.now + 7.hours )}

    before do
      category.add_subject(subject)
    end

    describe "#add_course" do

      it "should add course successfully" do
        expect {
          instructor.add_course(course)
        }.to change(instructor.courses, :count).by(1)
        expect(instructor.courses.first.subject).to eq(subject)
        expect(instructor.courses.first.subject.category).to eq(category)
      end

      it "should add course failured if user is student" do
        expect {
          student.add_course(course)
        }.to change(student.courses, :count).by(0)
      end
    end

    describe "#remove_course" do
      it "should remove course successfully" do
        instructor.add_course(course)
        expect {
          instructor.remove_course(course)
        }.to change(instructor.courses, :count).by(-1)
      end
    end
  end
end
