# frozen_string_literal: true

class App
  class Hand
    def initialize
      @cards = []
    end

    def +(cards)
      @cards += cards
      self
    end

    def to_s
      @cards.join(",")
    end

    def each
      @cards.each { yield(_1) }
    end

    def [](i)
      @cards[i]
    end
  end
end
