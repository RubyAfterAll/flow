# frozen_string_literal: true

require_relative "flow/callbacks"
require_relative "flow/core"
require_relative "flow/flux"
require_relative "flow/operations"
require_relative "flow/status"
require_relative "flow/transactions"
require_relative "flow/trigger"

# A **Flow** is a collection of procedurally executed **Operations** sharing a common **State**.
module Flow
  class FlowBase < Substance::RootObject
    include Conjunction::Junction
    suffixed_with "Flow"

    include TransactionWrapper
    include Flow::Callbacks
    include Flow::Core
    include Flow::Flux
    include Flow::Operations
    include Flow::Status
    include Flow::Transactions
    include Flow::Trigger
  end
end
