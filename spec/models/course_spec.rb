require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
    it { is_expected.to have_field(:start_time).of_type(DateTime) }
    it { is_expected.to have_field(:end_time).of_type(DateTime) }
    it { is_expected.to have_field(:capacity).of_type(Integer) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:subject).of_type(Subject) }
    it { is_expected.to belong_to(:user).of_type(User) }
  end
end
