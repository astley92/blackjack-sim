# frozen_string_literal: true

require_relative("./deck.rb")

class App
  class Dealer
    DECK_THRESHOLD = 20

    def initialize
      @deck = App::Deck.new
    end

    def deal(amount = 1)
      cards = []
      amount.times { cards << @deck.pop }
      cards
    end

    def start_hand
      if @deck.count < DECK_THRESHOLD
        App::Logger.debug("New deck")
        @deck = App::Deck.new
      end
    end
  end
end
