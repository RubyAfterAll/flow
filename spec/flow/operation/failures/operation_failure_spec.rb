# frozen_string_literal: true

RSpec.describe Flow::Operation::Failures::OperationFailure, type: :subclass do
  subject(:example_failure) { described_class.new(problem, **details) }

  let(:problem) { Faker::Internet.domain_word.underscore.to_sym }
  let(:details) { Hash[*Faker::Lorem.words(number: 4)].symbolize_keys }

  it { is_expected.to inherit_from StandardError }

  describe "#initialize" do
    context "with a problem and details" do
      it "structures the details of the given problem" do
        expect(example_failure.message).to eq problem.to_s
        expect(example_failure.problem).to eq problem
        expect(example_failure.details).to eq OpenStruct.new(details)
      end
    end

    context "with a problem but no details" do
      let(:details) { {} }

      it "creates an empty structures for the given problem" do
        expect(example_failure.message).to eq problem.to_s
        expect(example_failure.problem).to eq problem
        expect(example_failure.details).to eq OpenStruct.new
      end
    end

    context "without a problem or details" do
      let(:problem) { nil }
      let(:details) { {} }

      it "creates an empty structures for the unknown problem" do
        expect(example_failure.message).to eq described_class.name
        expect(example_failure.problem).to eq nil
        expect(example_failure.details).to eq OpenStruct.new
      end
    end
  end
end
