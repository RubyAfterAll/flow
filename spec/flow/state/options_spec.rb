# frozen_string_literal: true

RSpec.describe Flow::State::Options, type: :module do
  describe ".option" do
    include_context "with an example state"

    let(:option) { Faker::Lorem.word.to_sym }

    context "with output option" do
      subject(:define_option) { example_state_class.__send__(:option, option, output: output) }

      context "with output:true" do
        let(:output) { true }

        it "adds to _outputs" do
          expect { define_option }.to change { example_state_class._outputs }.from([]).to([option])
        end

        it "adds to _options" do
          expect { define_option }.to change { example_state_class._options }.from([]).to([option])
        end
      end

      context "with output:false" do
        let(:output) { false }

        it "does not add to _outputs" do
          expect { define_option }.to_not change { example_state_class._outputs }.from([])
        end

        it "adds to _options" do
          expect { define_option }.to change { example_state_class._options }.from([]).to([option])
        end
      end
    end

    context "without output option" do
      subject(:define_option) { example_state_class.__send__(:option, option) }

      it "does not add to _outputs" do
        expect { define_option }.to_not change { example_state_class._outputs }.from([])
      end

      it "adds to _options" do
        expect { define_option }.to change { example_state_class._options }.from([]).to([option])
      end
    end
  end
end
