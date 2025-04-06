# frozen_string_literal: true

class Player
  attr_accessor :strategy
  attr_accessor :balance

  def initialize(strategy:)
    @strategy = strategy
    @balance = 0
  end

  def bet_amount
    10
  end

  def next_action(hand, context)
    @strategy.next_action(hand, context)
  end
end
