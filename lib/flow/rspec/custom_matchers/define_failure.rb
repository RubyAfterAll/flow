# frozen_string_literal: true

# RSpec matcher that tests usage of `ApplicationOperation.failure`
#
#     class ExampleOperation
#       failure :foo
#     end
#
#     RSpec.describe ExampleOperation, type: :operation do
#       subject { described_class.new(**input) }
#
#       let(:input) { {} }
#
#       it { is_expected.to define_failure :foo }
#     end

RSpec::Matchers.define :define_failure do |problem|
  match { |operation| expect(operation._failures).to include problem.to_sym }
  description { "defines failure #{problem}" }
  failure_message { |operation| "expected #{operation.class.name} to define failure #{problem}" }
end
