# frozen_string_literal: true

require_relative "../support/test_classes/take_bottles_down"

RSpec.describe TakeBottlesDown, type: :operation do
  subject { described_class.new(double) }

  it { is_expected.to wrap_in_transaction }
  it { is_expected.to define_failure :too_greedy }
  it { is_expected.to handle_error described_class::NonTakedownError, with: :a_block }

  it { is_expected.to access_state :bottles }
  it { is_expected.to access_state :stanza }
  it { is_expected.to read_state :number_to_take_down }
  it { is_expected.to read_state :taking_down_one? }
  it { is_expected.to read_state :bottles_of }
end
