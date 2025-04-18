# frozen_string_literal: true

# Dealer hits until 17 or better
# Dealer hits soft 17

module Strategies::StandardDealer
  module_function

  def name
    "Standard Dealer"
  end

  def next_action(hand, _)
    return Actions::HIT if hand.value < 17
    return Actions::HIT if hand.value == 17 && hand.soft?

    Actions::STAND
  end
end
