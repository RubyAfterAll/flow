# frozen_string_literal: true

# Allows operations to be called outside of a flow via .call and .call!.
module Flow
  module Operation
    module Call
      extend ActiveSupport::Concern

      class_methods do
        def call(**kwargs)
          new(introspected_state_class.new(kwargs)).execute
        end

        def call!(**kwargs)
          new(introspected_state_class.new(kwargs)).execute!
        end
      end
    end
  end
end
