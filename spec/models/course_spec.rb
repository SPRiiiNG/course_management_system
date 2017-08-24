require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:start_time).of_type(DateTime) }
    it { is_expected.to have_field(:end_time).of_type(DateTime) }
    it { is_expected.to have_field(:capacity).of_type(Integer) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:subject).of_type(Subject) }
    it { is_expected.to belong_to(:user).of_type(User) }
  end

  describe "Methods" do
    let(:course)        { FactoryGirl.build(:course) }
    let(:subject)       { Subject.new(name: 'Subject 1') }
    let(:category)      { Category.create(name: 'Category 1') }
    let(:instructor)     { FactoryGirl.create(:user, instructor: true) }

    before do
      category.add_subject(subject)
    end
    describe "#category" do
      it "should return category correctly" do
        course.subject = subject
        instructor.add_course(course)
        expect(course.reload.category).to eq(category)
      end
    end
  end
end
