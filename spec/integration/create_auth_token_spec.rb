# frozen_string_literal: true

require_relative "../support/test_classes/create_auth_token"
require_relative "../support/test_classes/user"

RSpec.describe CreateAuthToken, type: :operation do
  subject(:operation) { described_class.new(state) }

  let(:state) { example_state_class.new(**state_input).tap(&:validate) }
  let(:example_state_class) do
    Class.new(Flow::StateBase) do
      option :user

      output :auth_token
    end
  end
  let(:state_input) do
    {}
  end

  it { is_expected.to inherit_from Flow::OperationBase }

  it { is_expected.to read_state :user }
  it { is_expected.to write_state :auth_token }

  it { is_expected.to define_failure :invalid_user }

  describe "#execute!" do
    include_context "with a users active record"

    subject(:execute) { operation.execute }

    let(:user) { User.create(email: Faker::Internet.email, password: Faker::Internet.password) }
    let(:state_input) do
      { user: user }
    end

    context "with invalid user" do
      let(:user) { nil }

      it { is_expected.to be_failed }

      it "has expected problem" do
        expect { execute }.to change { operation.operation_failure&.problem }.to(:invalid_user)
      end

      it "doesn't set output" do
        expect { execute }.not_to change { state.auth_token }.from(nil)
      end
    end

    context "with valid user" do
      let(:expected_auth_token) { "trust_me.#{user.id}" }

      it { is_expected.to be_success }

      it "has no problems" do
        expect { execute }.not_to change { operation.operation_failure&.problem }.from(nil)
      end

      it "sets output" do
        expect { execute }.to change { state.auth_token }.from(nil).to(expected_auth_token)
      end
    end
  end
end
