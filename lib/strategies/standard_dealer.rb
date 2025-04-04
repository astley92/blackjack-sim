# frozen_string_literal: true

module Strategies::StandardDealer
  module_function

  def next_action(hand, _)
    return Actions::HIT if hand.value < 17
    return Actions::HIT if hand.value == 17 && hand.soft?

    Actions::STAND
  end
end
