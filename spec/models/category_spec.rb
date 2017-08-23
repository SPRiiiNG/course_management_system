require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "Associations" do
    it { is_expected.to have_many(:subjects).of_type(Subject) }
  end

  describe "Methods" do
    let(:category)    { Category.create(name: 'technology') }
    let(:subject_1)   { Subject.new(name: 'Computer Programming 1') }

    describe "#add_subject" do
      it "should add subject successfully" do
        expect {
          category.add_subject(subject_1)
        }.to change(category.subjects, :count).by(1)
      end
    end

    describe "#remove_subject" do
      it "should remove subject successfully" do
        category.add_subject(subject_1)
        category.reload
        expect {
          category.remove_subject(subject_1)
        }.to change(category.subjects, :count).by(-1)
      end
    end
  end
end
