# frozen_string_literal: true

# RSpec matcher that tests usage of `ApplicationOperation.state_reader`
#
#     class SomeTask < ApplicationOperation
#       state_reader :foo
#       state_reader :bar
#     end
#
#     RSpec.describe SomeTask, type: :operation do
#       subject { described_class.new(state) }
#
#       let(:state) { Class.new(ApplicationState).new }
#
#       it { is_expected.to read_state :foo }
#       it { is_expected.to read_state :bar }
#     end

RSpec::Matchers.define :read_state do |field|
  match { |operation| expect(operation._state_readers).to include field }
  description { "read state" }
  failure_message { "expected #{described_class} to read state #{field}" }
end
