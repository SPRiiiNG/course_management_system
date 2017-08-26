require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:student)       { FactoryGirl.create(:user) }
  let(:instructor)     { FactoryGirl.create(:user, instructor: true) }
  let(:category)      { Category.create(name: 'Category 1') }
  let(:subject)       { Subject.new(name: 'Subject 1') }
  let(:course)        { FactoryGirl.build(:course, subject: subject) }

  before do
    category.add_subject(subject)
    instructor.add_course(course)
  end

  describe "GET" do
    describe "#index" do
      it "should return http success" do
        sign_in_as(student) do
          get :index
          expect(response).to be_success
        end
      end
    end

    describe "#show" do
      it "should return http success" do
        sign_in_as(student) do
          get :show,
            params: {
              id: course.id
            }
          expect(response).to be_success
        end
      end
    end
  end
end
