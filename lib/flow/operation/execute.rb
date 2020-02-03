# frozen_string_literal: true

# Operations define a `#behavior` that occurs when `#execute` is called.
module Flow
  module Operation
    module Execute
      extend ActiveSupport::Concern

      included do
        include ActiveSupport::Rescuable

        attr_reader :operation_failure

        set_callback :execute, :around, ->(_, block) { surveil(:execute) { block.call } }
        set_callback :execute, :before, -> { raise AlreadyExecutedError }, if: :executed?
      end

      def execute!
        run_callbacks(:execute) do
          run_callbacks(:behavior) { behavior }
        end

        self
      rescue StandardError => exception
        rescue_with_handler(exception) || raise

        self
      end

      def execute
        execute!
      rescue Operation::Failures::OperationFailure => exception
        @operation_failure = exception

        self
      end

      def behavior
        # abstract method which should be defined by descendants with the functionality of the given operation
      end
    end
  end
end
