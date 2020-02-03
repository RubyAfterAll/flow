# frozen_string_literal: true

# RSpec matcher that tests usage of `ApplicationOperation.state_writer`
#
#     class SomeTask < ApplicationOperation
#       state_writer :foo
#       state_writer :bar
#     end
#
#     RSpec.describe SomeTask, type: :operation do
#       subject { described_class.new(state) }
#
#       let(:state) { Class.new(ApplicationState).new }
#
#       it { is_expected.to write_state :foo }
#       it { is_expected.to write_state :bar }
#     end

RSpec::Matchers.define :write_state do |field|
  match { |operation| expect(operation._state_writers).to include field }
  description { "write state" }
  failure_message { "expected #{described_class} to write state #{field}" }
end
