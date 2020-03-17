# frozen_string_literal: true

module Flow
  module Malfunction
    class FailedOperation < Base
      contextualize :operation
      delegate :operation_failure, to: :operation
      delegate :problem, :details, to: :operation_failure

      private

      def details=(value)
        raise ArgumentError, "Details cannot be assigned to #{self.class.name}" if value.present?
      end
    end
  end
end
