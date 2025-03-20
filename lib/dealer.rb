# frozen_string_literal: true

class Dealer
  attr_accessor :deck
  def initialize
    @deck = nil
  end

  def deal
    raise RuntimeError, "dealer cannot deal without a deck" if @deck.nil?

  return @deck.shift
  end
end
