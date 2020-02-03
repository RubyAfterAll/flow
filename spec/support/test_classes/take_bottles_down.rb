# frozen_string_literal: true

class TakeBottlesDown < Flow::OperationBase
  wrap_in_transaction

  state_accessor :bottles
  state_accessor :stanza
  state_reader :number_to_take_down
  state_reader :taking_down_one?
  state_reader :bottles_of

  class NonTakedownError < StandardError; end

  failure :too_greedy
  failure :too_dangerous, if: -> { bottles_of == "tequila" }
  handle_error NonTakedownError do
    stanza.push "You took nothing down."
  end

  on_failure do
    stanza.push "Something went wrong! It's the end of the song, and there's #{bottles} on the wall."
  end

  set_callback(:execute, :before) { bottle_count_term }
  set_callback(:execute, :after) { stanza.push "You take #{bottle_count_term} down." }

  def behavior
    too_greedy_failure! if number_to_take_down >= 5
    raise NonTakedownError if number_to_take_down == 0

    bottles.update!(number_on_the_wall: bottles.number_on_the_wall - number_to_take_down)
  end

  private

  def bottle_count_term
    return "it" if bottles.number_on_the_wall == 1
    return "one" if taking_down_one?

    number_to_take_down
  end
  memoize :bottle_count_term
end
