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

        private

        def introspected_state_class
          Class.new(StateBase).tap do |state_class|
            [*_state_readers, *_state_writers, *_state_accessors].each do |method_name|
              state_class.__send__(:attr_accessor, method_name)
            end
          end
        end
      end
    end
  end
end
