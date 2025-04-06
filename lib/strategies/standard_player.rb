# frozen_string_literal: true

# Hits until 17 or better
# Hits soft 17

module Strategies::StandardPlayer
  module_function

  def name
    "Standard Player"
  end

  def next_action(hand, _)
    return Actions::HIT if hand.value < 17
    return Actions::HIT if hand.value == 17 && hand.soft?

    Actions::STAND
  end
end
