# frozen_string_literal: true

class App
  class Seat
    attr_accessor :hand, :score, :bet_amount
    attr_reader :player

    def initialize(player:)
      @player = player
      @hand = nil
      @score = nil
      @bet_amount = 0
    end

    def bust?
      @score.bust?
    end

    def reset(hand)
      @hand = hand
      @score = nil
    end
  end
end
