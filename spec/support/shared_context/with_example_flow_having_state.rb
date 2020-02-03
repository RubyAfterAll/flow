# frozen_string_literal: true

RSpec.shared_context "with example flow having state" do
  subject(:example_flow) { example_flow_class.new }

  let(:example_flow_class) { Class.new(Flow::FlowBase) }

  let(:example_name) { Faker::Internet.domain_word.capitalize }
  let(:example_flow_name) { "#{example_name}Flow" }
  let(:example_state_name) { "#{example_name}State" }
  let(:example_state_class) { Class.new(Flow::StateBase) }

  before do
    stub_const(example_flow_name, example_flow_class)
    stub_const(example_state_name, example_state_class)
  end
end
