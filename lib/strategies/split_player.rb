# frozen_string_literal: true

# Hits until 17 or better
# Hits soft 17
# Splits pairs of 8s

module Strategies::SplitPlayer
  module_function

  def name
    "Split Player"
  end

  def next_action(hand, _)
    return Actions::SPLIT if hand.cards.all? { _1.value == 8 }
    return Actions::HIT if hand.value < 17
    return Actions::HIT if hand.value == 17 && hand.soft?

    Actions::STAND
  end
end
