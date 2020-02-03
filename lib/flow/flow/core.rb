# frozen_string_literal: true

# Accepts input representing the arguments and options which define the initial state.
module Flow
  module Flow
    module Core
      extend ActiveSupport::Concern

      class_methods do
        def state_class
          conjugate(StateBase)
        end
      end

      included do
        delegate :state_class, to: :class
        delegate :outputs, to: :state

        attr_reader :state
      end

      def initialize(state_instance = nil, **options)
        run_callbacks(:initialize) do
          @state = state_instance || state_class.new(**options)
        end
      end
    end
  end
end
