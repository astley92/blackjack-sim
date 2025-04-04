# frozen_string_literal: true

class Deck
  include Enumerable

  attr_reader :cards

  def initialize
    @cards = []
    Card::RANKS.each do |rank|
      Card::SUITS.each do |suit|
        @cards << Card.new(rank, suit)
      end
    end
  end

  def each
    @cards.each { yield(_1) }
  end

  def shift
    @cards.shift
  end

  def shuffle
    @cards.shuffle!
  end

  def merge(other)
    raise ArgumentError, "Expected #{self.class.name} got #{other.class.name}" unless other.instance_of?(self.class)

    @cards += other.cards
  end

  class Card
    RANK_VALUE_MAP = {
      "A" => 11,
      "K" => 10,
      "Q" => 10,
      "J" => 10,
      "T" => 10,
      "9" => 9,
      "8" => 8,
      "7" => 7,
      "6" => 6,
      "5" => 5,
      "4" => 4,
      "3" => 3,
      "2" => 2,
    }.freeze
    RANKS = RANK_VALUE_MAP.keys.freeze
    SUITS = %w[H C D S].freeze

    attr_reader :rank, :suit, :value
    def initialize(rank, suit)
      @rank = rank
      @suit = suit
      @value = RANK_VALUE_MAP.fetch(rank)
    end

    def to_s
      @rank + @suit
    end
  end
end
