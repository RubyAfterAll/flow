module Flow
  module State
    module Outputs
      extend ActiveSupport::Concern

      class_methods do
        private

        def ensure_validation_before(method)
          attr_name = method.to_s.delete("=").to_sym
          return if [*_options, *_arguments.keys].include? attr_name

          super(method)
        end
      end
    end
  end
end
