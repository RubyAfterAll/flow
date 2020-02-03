# frozen_string_literal: true

require_relative "../support/test_classes/sign_in_state"

RSpec.describe SignInState, type: :state do
  include_context "with a users active record"

  it { is_expected.to inherit_from Flow::StateBase }

  it { is_expected.to include_module ValidCredentials }

  it { is_expected.to define_option :email }
  it { is_expected.to define_option :password }

  it { is_expected.to define_output :auth_token }

  it_behaves_like "credentials are validated"

  describe "#user" do
    subject(:state) { described_class.new(email: email, password: password) }

    let(:password) { Faker::Internet.password }

    before { state.validate }

    shared_examples_for "the user is not present" do
      it { is_expected.not_to be_valid }

      it "has nil user" do
        expect(state.user).to be_nil
      end

      it "has expected error details" do
        expect(state.errors.details).to eq user: [ error: :blank ]
      end
    end

    context "with an unknown email" do
      let(:email) { Faker::Internet.email }

      it_behaves_like "the user is not present"
    end

    context "with a user email" do
      let(:user) { User.create(email: Faker::Internet.email, password: Faker::Internet.password) }
      let(:email) { user.email }

      context "with an invalid password" do
        it_behaves_like "the user is not present"
      end

      context "with a valid password" do
        let(:user) { User.create(email: Faker::Internet.email, password: password) }

        it { is_expected.to be_valid }

        it "has expected user" do
          expect(state.user).to eq user
        end
      end
    end
  end
end
