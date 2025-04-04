# frozen_string_literal: true

class Hand
  attr_reader :owner, :bet_amount
  def initialize(owner:, bet_amount: nil)
    @owner = owner
    @bet_amount = bet_amount
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def value
    values = @cards.map(&:value)
    initial_value = values.sum
    return initial_value if initial_value <= 21
    return initial_value if values.none? { _1 == 11 }

    while values.index(11)
      values[values.index(11)] = 1
      new_value = values.sum
      return new_value if new_value <= 21
    end

    values.sum
  end

  def soft?
    values = @cards.map(&:value)
    return false unless values.any? { _1 == 11 }
    return true if values.sum <= 21

    while values.index(11)
      values[values.index(11)] = 1
      new_value = values.sum
      return true if new_value <= 21 && values.any? { _1 == 11 }
    end

    false
  end

  def bust?
    value > 21
  end

  def to_s
    @cards.map(&:to_s).join(", ")
  end
end
