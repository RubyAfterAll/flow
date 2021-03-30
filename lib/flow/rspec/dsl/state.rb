# frozen_string_literal: true

module Flow
  module RSpec
    module DSL
      module State
        def state(&block)
          Class.new(Flow::State).tap do |state_class|
            state_class.instance_exec(&block)
          end
        end
      end
    end
  end
end
