# frozen_string_literal: true

RSpec.shared_examples_for "credentials are validated" do
  it { is_expected.to include_module ValidCredentials }

  describe "#password" do
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(20) }
  end

  describe "#email" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value("a@b.c").for(:email) }
    it { is_expected.to allow_value("more.complex+ema.il-thing@still.ok.gov").for(:email) }
    it { is_expected.not_to allow_value("email with space@not.ok").for(:email) }
    it { is_expected.not_to allow_value("@twitter.fails").for(:email) }
    it { is_expected.not_to allow_value("gmail.com").for(:email) }
  end
end
