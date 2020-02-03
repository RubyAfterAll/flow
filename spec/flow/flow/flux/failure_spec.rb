# frozen_string_literal: true

RSpec.describe Flow::Flow::Flux::Failure, type: :error do
  it { is_expected.to inherit_from StandardError }
end
