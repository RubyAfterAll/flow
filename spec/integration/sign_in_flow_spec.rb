# frozen_string_literal: true

require_relative "../support/test_classes/sign_in_flow"

RSpec.describe SignInFlow, type: :flow do
  subject { described_class.new }

  it { is_expected.to use_operations CreateAuthToken }
  it { is_expected.not_to wrap_in_transaction }
end
