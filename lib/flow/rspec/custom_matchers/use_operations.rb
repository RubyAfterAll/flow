# frozen_string_literal: true

# RSpec matcher that tests usage of `ApplicationFlow.operations`
#
#     class ExampleFlow
#       operations OperationOne, OperationTwo
#     end
#
#     RSpec.describe ExampleFlow, type: :flow do
#       subject { described_class.new(**input) }
#
#       let(:input) { {} }
#
#       it { is_expected.to use_operations OperationOne, OperationTwo }
#     end

RSpec::Matchers.define :use_operations do |*operations|
  match { |flow| expect(flow._operations).to eq operations.flatten }
  description { "uses operations #{display_operations(operations)}" }
  failure_message { |flow| "expected #{flow.class.name} to use operations #{display_operations(operations)}" }

  def display_operations(operations)
    operations.flatten.join(", ")
  end
end
