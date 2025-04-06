# frozen_string_literal: true

# Hits until 17 or better
# Hits soft 17
# Doubles 11's

module Strategies::DoublePlayer
  module_function

  def name
    "Double Player"
  end

  def next_action(hand, _)
    return Actions::DOUBLE if hand.count == 2 && hand.value == 11
    return Actions::HIT if hand.value < 17
    return Actions::HIT if hand.value == 17 && hand.soft?

    Actions::STAND
  end
end
