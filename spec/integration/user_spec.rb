# frozen_string_literal: true

require_relative "../support/test_classes/user"

RSpec.describe User, type: :model do
  include_context "with a users active record"

  subject(:described_model) { User.new(email: Faker::Internet.email, password: Faker::Internet.password) }

  it { is_expected.to be_a_kind_of ActiveRecord::Base }

  it { is_expected.to have_secure_password }

  it { is_expected.to have_db_index(:email).unique }

  it_behaves_like "credentials are validated" do
    subject(:described_model) { User.new(email: Faker::Internet.email) }
  end

  describe "#email" do
    let(:upcased_email) { Faker::Internet.email.upcase }
    let(:downcased_email) { upcased_email.downcase }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it "downcases the email" do
      expect { described_model.update(email: upcased_email) }.to change { described_model.email }.to(downcased_email)
    end
  end

  describe "#password" do
    subject(:described_model) { User.new(email: Faker::Internet.email, password: nil) }

    it "digests the password" do
      expect { described_model.update!(password: SecureRandom.hex(8)) }.
        to change { described_model.password_digest }.
        from nil
    end
  end
end
