# frozen_string_literal: true

require_relative "../../support/test_classes/bottles_on_the_wall_flow"

RSpec.describe "with invalid state" do
  subject(:flow) { BottlesOnTheWallFlow.new(bottles_of: :test_fluid) }

  let(:invalid_state_class) { BottlesOnTheWallState }
  let(:expected_state_errors) do
    {
      bottles_of: "must be test fluid",
      starting_bottles: :must_be_negative,
    }
  end

  include_context "with invalid state"

  before { flow.trigger }

  it "adds errors to the state" do
    expect(flow).not_to be_success
    expect(flow.state.errors).to be_present
    expect(flow.state.errors[:bottles_of]).to eq([ expected_state_errors[:bottles_of] ])
    expect(flow.state.errors.details.dig(:starting_bottles, 0, :error)).to eq expected_state_errors[:starting_bottles]
  end
end
