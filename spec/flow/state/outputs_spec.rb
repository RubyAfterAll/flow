# frozen_string_literal: true

RSpec.describe Flow::State::Outputs, type: :module do
  include_context "with an example state"

  shared_context "with example state having output" do
    let(:example_state) { example_class.new }
    let(:example_class) do
      Class.new(example_state_class) do
        output :test_output0
        output :test_output1, default: :default_value1
        output(:test_output2) { :default_value2 }
      end
    end

    before do
      stub_const(Faker::Internet.unique.domain_word.underscore.capitalize, example_state_class)
      stub_const(Faker::Internet.unique.domain_word.underscore.capitalize, example_class)
    end
  end

  describe "#outputs" do
    subject(:outputs) { example_state.outputs }

    context "without any outputs" do
      it { is_expected.to eq({}) }
    end

    context "with outputs" do
      include_context "with example state having output"

      context "when not validated" do
        context "when outputs" do
          it "raises" do
            expect { example_state.outputs }.to raise_error Spicerack::NotValidatedError
          end
        end

        context "when arguments are also outputs" do
          let(:example_state) { example_class.new(state_inputs) }
          let(:state_inputs) do
            { test_output0: nil, test_output1: :input_value1, test_output2: :input_value2 }
          end
          let(:expected_outputs) { state_inputs }

          let(:example_class) do
            Class.new(example_state_class) do
              argument :test_output0, output: true
              argument :test_output1, output: true
              argument :test_output2, output: true
            end
          end

          it { is_expected.to have_attributes(**expected_outputs) }
        end

        context "when options are also outputs" do
          let(:expected_outputs) do
            { test_output0: nil, test_output1: :default_value1, test_output2: :default_value2 }
          end

          let(:example_class) do
            Class.new(example_state_class) do
              option :test_output0, output: true
              option :test_output1, default: :default_value1, output: true
              option(:test_output2, output: true) { :default_value2 }
            end
          end

          it { is_expected.to have_attributes(**expected_outputs) }
        end
      end

      context "when validated" do
        let(:expected_outputs) do
          { test_output0: nil, test_output1: :default_value1, test_output2: :default_value2 }
        end

        before { example_state.validate }

        it { is_expected.to have_attributes(**expected_outputs) }
      end
    end
  end
end
