module Flow
  module State
    module Arguments
      extend ActiveSupport::Concern

      class_methods do
        private

        def argument(argument, output: false, **options)
          _outputs << argument if output
          super(argument, **options)
        end
      end
    end
  end
end
