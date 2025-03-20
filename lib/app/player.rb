# frozen_string_literal: true

class App
  class Player
    module Actions
      STAND = :stand
      HIT = :hit
    end

    attr_accessor :bank
    def initialize(name:)
      @current_hand = nil
      @name = name
      @bank = 0
    end

    def set_current_hand(hand)
      @current_hand = hand
    end

    def next_action(hand, dealer_card)
      [1, 2].shuffle[0] == 1 ? Actions::STAND : Actions::HIT
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
