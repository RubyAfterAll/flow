# frozen_string_literal: true

RSpec.shared_context "with an example operation" do
  subject(:example_operation) { example_operation_class.new(example_state) }

  let(:example_operation_class) { Class.new(Flow::OperationBase) }

  let(:example_state_class) { Class.new(Flow::StateBase) }
  let(:example_state) { example_state_class.new }

  let(:example_operation_name) { Faker::Internet.domain_word.capitalize }
  let(:example_state_name) { "#{example_operation_name}State" }

  before do
    stub_const(example_operation_name, example_operation_class)
    stub_const(example_state_name, example_state_class)
  end
end
