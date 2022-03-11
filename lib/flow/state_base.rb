# frozen_string_literal: true

# A **State** is an aggregation of input and derived data.
module Flow
  class StateBase < Substance::OutputObject
    include Conjunction::Junction
    suffixed_with "State"
  end
end
