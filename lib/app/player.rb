# frozen_string_literal: true

class App
  class Player
    attr_accessor :bank

    def initialize(name:, strategy:)
      @current_hand = nil
      @name = name
      @bank = 0
      @strategy = strategy
    end

    def set_current_hand(hand)
      @current_hand = hand
    end

    def next_action(hand, dealer_card)
      @strategy.decision(hand, dealer_card)
    end

    def place_bet
      @bank -= 50
      50
    end

    def to_s
      @name
    end
  end
end
