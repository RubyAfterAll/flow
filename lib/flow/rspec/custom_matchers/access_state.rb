# frozen_string_literal: true

# RSpec matcher that tests usage of `ApplicationOperation.state_accessor` (or use of both `state_(reader|writer)`)
#
#     class SomeTask < ApplicationOperation
#       state_accessor :foo
#       state_accessor :bar
#
#       state_reader :baz
#       state_writer :baz
#     end
#
#     RSpec.describe SomeTask, type: :operation do
#       subject { described_class.new(state) }
#
#       let(:state) { Class.new(ApplicationState).new }
#
#       it { is_expected.to access_state :foo }
#       it { is_expected.to access_state :bar }
#       it { is_expected.to access_state :baz }
#     end

RSpec::Matchers.define :access_state do |field|
  match { |operation| expect(operation._state_accessors).to include field }
  description { "access state" }
  failure_message { "expected #{described_class} to access state #{field}" }
end
