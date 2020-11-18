# frozen_string_literal: true

RSpec.describe Flow::State::Arguments, type: :module do
  describe ".argument" do
    include_context "with an example state"

    let(:argument) { Faker::Lorem.word.to_sym }

    context "with output option" do
      subject(:define_argument) { example_state_class.__send__(:argument, argument, output: output) }

      context "with output:true" do
        let(:output) { true }

        it "adds to _outputs" do
          expect { define_argument }.to change { example_state_class._outputs }.from([]).to([argument])
        end

        it "adds to _arguments" do
          expect { define_argument }.to change { example_state_class._arguments }.from({}).to(argument => { allow_nil: true })
        end
      end

      context "with output:false" do
        let(:output) { false }

        it "does not add to _outputs" do
          expect { define_argument }.to_not change { example_state_class._outputs }.from([])
        end

        it "adds to _arguments" do
          expect { define_argument }.to change { example_state_class._arguments }.from({}).to(argument => { allow_nil: true })
        end
      end
    end

    context "without output option" do
      subject(:define_argument) { example_state_class.__send__(:argument, argument) }

      it "does not add to _outputs" do
        expect { define_argument }.to_not change { example_state_class._outputs }.from([])
      end

      it "adds to _arguments" do
        expect { define_argument }.to change { example_state_class._arguments }.from({}).to(argument => { allow_nil: true })
      end
    end
  end
end
