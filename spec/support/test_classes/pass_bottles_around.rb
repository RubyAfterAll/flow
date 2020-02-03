# frozen_string_literal: true

class PassBottlesAround < Flow::OperationBase
  wrap_in_transaction

  state_accessor :bottles
  state_accessor :stanza
  state_reader :number_to_take_down
  state_reader :taking_down_one?
  state_reader :bottles_of

  class NonTakedownError < StandardError; end

  BORING_DRINKS = %w[juice water soda pop]

  failure :too_generous
  failure :not_dangerous_enough, unless: :drink_not_boring?
  handle_errors ActiveRecord::RecordInvalid
  handle_error NonTakedownError, with: :non_takedown_handler

  on_record_invalid_failure do
    stanza.push "Passing the bottles wasn't as sound, now there's #{number_to_take_down} on the ground!"
  end

  set_callback(:execute, :after) { stanza.push "You pass #{taking_down_one? ? "it" : "them"} around." }

  def behavior
    too_generous_failure! if number_to_take_down >= 4
    raise NonTakedownError if number_to_take_down == 0

    bottles.update!(number_passed_around: bottles.number_passed_around + number_to_take_down)
  end

  private

  def drink_not_boring?
    BORING_DRINKS.exclude? bottles_of
  end

  def non_takedown_handler
    stanza.push "You pass nothing around."
  end
end
