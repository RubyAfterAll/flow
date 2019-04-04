# frozen_string_literal: true

class PassBottlesAround < OperationBase
  wrap_in_transaction only: :behavior

  class NonTakedownError < StandardError; end

  failure :too_generous
  handle_error ActiveRecord::RecordInvalid
  handle_error NonTakedownError, with: :non_takedown_handler

  on_record_invalid_failure do
    state.output.push "Passing the bottles wasn't as sound, now there's #{state.number_to_take_down} on the ground!"
  end

  set_callback(:execute, :after) { state.output.push "You pass #{state.taking_down_one? ? "it" : "them"} around." }

  def behavior
    too_generous_failure! if state.number_to_take_down >= 4
    raise NonTakedownError if state.number_to_take_down == 0

    state.bottles.update!(number_passed_around: state.bottles.number_passed_around + state.number_to_take_down)
  end

  def undo
    state.bottles.update!(number_passed_around: state.bottles.number_passed_around - state.number_to_take_down)
  end

  private

  def non_takedown_handler
    state.output.push "You pass nothing around."
  end
end