# frozen_string_literal: true

require_relative "state/arguments"

# A **State** is an aggregation of input and derived data.
module Flow
  class StateBase < Spicerack::OutputObject
    include Conjunction::Junction
    suffixed_with "State"

    include State::Arguments
  end
end
