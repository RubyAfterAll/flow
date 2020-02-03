# frozen_string_literal: true

# RSpec matcher that tests usage of `ApplicationOperation.handle_error`
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

RSpec::Matchers.define :handle_error do |error_class, problem: error_class.name.demodulize.underscore, with: nil|
  match do |operation|
    handlers = operation.rescue_handlers.select { |handler| handler[0] == error_class.to_s }

    expect(handlers).to be_present

    if with.present?
      expect(handlers.find { |handler| (with == :a_block) ? handler[1].is_a?(Proc) : handler[1] == with }).to be_present
    end

    expect(operation).to define_failure problem
  end

  description { "handles error #{error_class}" }
  failure_message { |flow| "expected #{flow.class.name} to handle error #{error_class}" }
end
