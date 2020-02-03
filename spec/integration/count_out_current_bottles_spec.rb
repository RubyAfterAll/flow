# frozen_string_literal: true

require_relative "../support/test_classes/count_out_current_bottles"

RSpec.describe CountOutCurrentBottles, type: :operation do
  subject { described_class.new(double) }

  it { is_expected.not_to wrap_in_transaction }

  it { is_expected.to access_state :stanza }
  it { is_expected.to read_state :bottles }
end
