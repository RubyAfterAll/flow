# frozen_string_literal: true

RSpec.describe Flow::StateBase, type: :state do
  subject { described_class }

  it { is_expected.to inherit_from Substance::OutputObject }

  it { is_expected.to include_module Conjunction::Junction }
  it { is_expected.to have_conjunction_suffix "State" }
end
