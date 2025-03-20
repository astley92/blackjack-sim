# frozen_string_literal: true

require_relative("boot")

dealer = Dealer.new
dealer.deck = Deck.new

puts dealer.deal
