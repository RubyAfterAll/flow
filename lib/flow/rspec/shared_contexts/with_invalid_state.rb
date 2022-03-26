# frozen_string_literal: true

# Stubs a given flow to always fail when triggered.
#
# Usage:
#   describe SomeFlow do
#     let(:flow) { described_class.new(some: :arguments) }
#
#     include_context "with invalid state"
#
#     before { flow.trigger }
#
#     it "is failed" do
#       expect(flow).not_to be_successful
#       expect(flow.state.errors).to be_present
#     end
#   end
#
# Requires let variables to be defined in the inclusion context:
# * invalid_state_class - the state class that will be used for the flow
# * expected_state_errors - a hash in the form of:
#     { attribute_name: :error_key
#       # or:
#       another_attributee: "error message!"
#     }
RSpec.shared_context "with invalid state" do
  before do
    allow(invalid_state_class).to receive(:new).and_wrap_original do |mtd, **kwargs|
      mtd.call(**kwargs).tap do |state|
        allow(state).to receive(:run_validations!).and_wrap_original do |run_validations|
          run_validations.call

          expected_state_errors.each do |attr, error|
            state.errors.add(attr, error)
          end

          false
        end
      end
    end
  end
end
