# frozen_string_literal: true

# Allows operations to be called outside of a flow via .trigger and .trigger!.
module Flow
  module Operation
    module StandAlone
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
            introspected_state_options.each { |method_name| state_class.__send__(:option, method_name) }
            introspected_state_outputs.each { |method_name| state_class.__send__(:output, method_name) }
          end
        end

        def introspected_state_options
          [*_state_readers, *_state_accessors].uniq
        end

        def introspected_state_outputs
          _state_writers - _state_accessors
        end
      end
    end
  end
end
