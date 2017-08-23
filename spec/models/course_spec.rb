require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
    it { is_expected.to have_field(:description).of_type(String) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:subject).of_type(Subject) }
    it { is_expected.to belong_to(:user).of_type(User) }
  end
end
