# frozen_string_literal: true

# Allows operations to be called outside of a flow via .trigger and .trigger!.
module Flow
  module Operation
    module Call
      extend ActiveSupport::Concern

      class_methods do
        def trigger(**kwargs)
          state = introspected_state_class.new(kwargs)
          return new(state) unless state.valid?

          new(state).execute
        end

        def trigger!(**kwargs)
          state = introspected_state_class.new(kwargs)
          raise StateInvalidError unless state.valid?

          new(state).execute!
        end
      end
    end
  end
end
