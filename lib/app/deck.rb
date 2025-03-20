# frozen_string_literal: true

class App
  class Deck
    SUITS = %w[H D S C]
    RANKS = %w[A K Q J T 9 8 7 6 5 4 3 2]

    def initialize
      @cards = build
    end

    def build
      cards = []
      SUITS.each do |suit|
        RANKS.each do |rank|
          cards << App::Card.new(suit: suit, rank: rank)
        end
      end
      cards.shuffle
    end

    def pop
      @cards.pop
    end

    def count
      @cards.count
    end
  end

  class Card
    attr_reader :rank
    def initialize(suit:, rank:)
      @suit = suit
      @rank = rank
    end

    def to_s
      "#{@rank}#{@suit}"
    end
  end
end
