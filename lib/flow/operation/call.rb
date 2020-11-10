# frozen_string_literal: true

# Allows operations to be called outside of a flow via .trigger and .trigger!.
module Flow
  module Operation
    module Call
      extend ActiveSupport::Concern

      class_methods do
        def trigger(**kwargs)
          new(introspected_state(kwargs)).execute
        end

        def trigger!(**kwargs)
          new(introspected_state(kwargs)).execute!
        end

        private

        def introspected_state(kwargs)
          # introspected_state_class instance should never be invalid, but needs to be validated for any defined outputs
          introspected_state_class.new(kwargs).tap { |state| state.valid? }
        end

        def introspected_state_class
          Class.new(StateBase).tap do |state_class|
            [*_state_readers, *_state_accessors].uniq.each do |method_name|
              state_class.__send__(:option, method_name)
            end
            _state_writers.each do |method_name|
              state_class.__send__(:output, method_name) unless _state_accessors.include?(method_name)
            end
          end
        end
      end
    end
  end
end
