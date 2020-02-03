# frozen_string_literal: true

require_relative "../support/test_classes/bottle"

RSpec.describe Bottle, type: :model do
  include_context "with a bottles active record"

  subject(:described_model) { Bottle.new(of: SecureRandom.hex) }

  it { is_expected.to be_a_kind_of ActiveRecord::Base }

  it { is_expected.to have_db_index(:of).unique }

  it { is_expected.to validate_numericality_of(:number_on_the_wall).is_greater_than_or_equal_to(0).only_integer }
  it { is_expected.to validate_numericality_of(:number_passed_around).is_greater_than_or_equal_to(0).only_integer }
  it { is_expected.to validate_numericality_of(:number_passed_around).is_less_than_or_equal_to(100).only_integer }
end
