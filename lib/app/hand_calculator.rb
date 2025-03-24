# frozen_string_literal: true

class App
  module HandCalculator
    def self.call(hand)
      score = Score.new
      hand.each do |card|
        score += card
      end
      score
    end

    class Score
      RANK_TO_VALUE = {
        "2" => 2,
        "3" => 3,
        "4" => 4,
        "5" => 5,
        "6" => 6,
        "7" => 7,
        "8" => 8,
        "9" => 9,
        "T" => 10,
        "J" => 10,
        "Q" => 10,
        "K" => 10,
        "A" => 11,
      }
      attr_reader :value
      def initialize
        @value = 0
      end

      def +(card)
        @value += RANK_TO_VALUE.fetch(card.rank)
        self
      end

      def bust?
        @value > 21
      end

      def to_s
        @value.to_s
      end

      def >(other)
        other.value < value
      end

      def ==(other)
        @value == other.value
      end
    end
  end
end
