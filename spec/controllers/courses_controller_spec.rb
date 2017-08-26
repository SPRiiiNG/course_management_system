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

    describe "#new" do
      it "should return http success" do
        sign_in_as(instructor) do
          get :new
          expect(response).to be_success
        end
      end

      it "should return http failured" do
        sign_in_as(student) do
          get :new
          expect(response).not_to be_success
          expect(response.status).to eq(403)
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

    describe "#edit" do
      it "should return http success and status 200" do
        sign_in_as(instructor) do
          get :edit,
            params: {
              id: course.id
            }
          expect(response).to be_success
          expect(response.status).to eq(200)
        end
      end

      it "should return http success and status 403" do
        sign_in_as(student) do
          get :edit,
            params: {
              id: course.id
            }
          expect(response).not_to be_success
          expect(response.status).to eq(403)
        end
      end
    end
  end

  describe "POST" do
    describe "#create" do
      it "should create successfully" do
        sign_in_as(instructor) do
          course_1 = FactoryGirl.build(:course, subject: subject)
          expect {
            post :create,
              params: {
                course: {
                  subject: course_1.subject.id.to_s,
                  name: course_1.name,
                  description: course_1.description,
                  start_time: course_1.start_time,
                  end_time: course_1.end_time,
                  capacity: course_1.capacity
                }
              }
          }.to change(instructor.courses, :count).by(1)
          expect(flash[:notice]).to be_present
        end
      end

      it "should create failured if subject is nil" do
        sign_in_as(instructor) do
          course_1 = FactoryGirl.build(:course, subject: subject)
          expect {
            post :create,
              params: {
                course: {
                  subject: 'asd2asdsa2d',
                  name: course_1.name,
                  description: course_1.description,
                  start_time: course_1.start_time,
                  end_time: course_1.end_time,
                  capacity: course_1.capacity
                }
              }
          }.to change(instructor.courses, :count).by(0)
          expect(flash[:error]).to be_present
        end
      end

      it "should create failured if user is student role" do
        sign_in_as(student) do
          course_1 = FactoryGirl.build(:course, subject: subject)
          expect {
            post :create,
              params: {
                course: {
                  subject: course_1.subject.id.to_s,
                  name: course_1.name,
                  description: course_1.description,
                  start_time: course_1.start_time,
                  end_time: course_1.end_time,
                  capacity: course_1.capacity
                }
              }
          }.to change(instructor.courses, :count).by(0)
          expect(response.status).to eq(403)
        end
      end
    end
  end

  describe "PUT/PATCH" do
    describe "#update" do
      it "should update correctly" do
        sign_in_as(instructor) do
          patch :update,
            params: {
              id: course.id,
              course: {
                subject: course.subject.id.to_s,
                name: 'eiei',
                description: course.description,
                start_time: course.start_time,
                end_time: course.end_time,
                capacity: course.capacity
              }
            }
          expect(course.reload.name).to eq('eiei')
          expect(flash[:notice]).to be_present
        end
      end

      it "should update failured if subject is nil" do
        sign_in_as(instructor) do
          patch :update,
            params: {
              id: course.id,
              course: {
                subject: 'asdasdaaa',
                name: course.name,
                description: course.description,
                start_time: course.start_time,
                end_time: course.end_time,
                capacity: course.capacity
              }
            }
          expect(course.reload.subject).to eq(subject)
          expect(flash[:error]).to be_present
        end
      end

      it "should update failured if subject is nil" do
        sign_in_as(student) do
          patch :update,
            params: {
              id: course.id,
              course: {
                subject: course.subject.id.to_s,
                name: 'asdasd',
                description: course.description,
                start_time: course.start_time,
                end_time: course.end_time,
                capacity: course.capacity
              }
            }
          expect(course.reload.subject).to eq(subject)
          expect(response.status).to eq(403)
        end
      end
    end
  end

  describe "DELETE" do
    describe "#destroy" do
      it "shold destroy course successfully" do
        sign_in_as(instructor) do
          expect {
            delete :destroy,
              params: {
                id: course.id
              }
          }.to change(instructor.courses, :count).by(-1)
        end
      end

      it "shold destroy course failured" do
        sign_in_as(student) do
          expect {
            delete :destroy,
              params: {
                id: course.id
              }
          }.to change(instructor.courses, :count).by(0)
          expect(response.status).to eq(403)
        end
      end
    end
  end
end
