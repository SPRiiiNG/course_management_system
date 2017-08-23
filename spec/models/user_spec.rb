require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Fields" do
    it { is_expected.to have_field(:first_name).of_type(String) }
    it { is_expected.to have_field(:last_name).of_type(String) }
    it { is_expected.to have_field(:nickname).of_type(String) }
    it { is_expected.to have_field(:birthday).of_type(DateTime) }
    it { is_expected.to have_field(:gender).of_type(String).with_default_value_of('male') }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_inclusion_of(:gender).to_allow("male", "female") }
  end
end
