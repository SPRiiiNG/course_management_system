require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:name).of_type(String) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:category).of_type(Category) }
  end
end
