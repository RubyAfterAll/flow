# frozen_string_literal: true

require "active_model"
require "active_record"
require "active_support"

require "spicery"
require "malfunction"

require "flow/version"

require "flow/concerns/transaction_wrapper"

require "flow/malfunction/base"
require "flow/malfunction/invalid_state"
require "flow/malfunction/failed_operation"

require "flow/flow_base"
require "flow/operation_base"
require "flow/state_base"
require "flow/state_proxy"

module Flow
  class Error < StandardError; end

  class FlowError < Error; end
  class StateInvalidError < FlowError; end
  class FluxError < FlowError; end

  class OperationError < Error; end
  class AlreadyExecutedError < OperationError; end

  class StateError < Error; end
  class NotValidatedError < StateError; end
end
