# frozen_string_literal: true

require_relative("boot")

HAND_COUNT = 1_000
DECK_COUNT = 2

deck = Deck.new
(DECK_COUNT - 1).times do
  deck.merge(Deck.new)
end
deck.shuffle

dealer = Player.new(strategy: Strategies::StandardDealer)
players = []
players << Player.new(strategy: Strategies::StandardDealer)
players << Player.new(strategy: Strategies::StandardDealer)
players << Player.new(strategy: Strategies::StandardDealer)

HAND_COUNT.times do |i|
  puts "--- HAND #{i + 1} ---"
  # place bets
  dealer_hand = Hand.new(owner: dealer)
  hands = players.map do |player|
    player.balance -= player.bet_amount
    Hand.new(owner: player, bet_amount: player.bet_amount)
  end

  # deal initial cards
  2.times do
    hands.each { _1.add_card(deck.shift) }
    dealer_hand.add_card(deck.shift)
  end

  # player actions
  unless dealer_hand.blackjack?
    hands.each do |hand|
      while !hand.bust? && hand.owner.next_action(hand, {}) != Actions::STAND
        hand.add_card(deck.shift)
      end
    end

    # dealer actions
    if hands.any? { !_1.bust? }
      while !dealer_hand.bust? && dealer.next_action(dealer_hand, {}) != Actions::STAND
        dealer_hand.add_card(deck.shift)
      end
    end
  end

  puts "Dealer has: #{dealer_hand.value}#{dealer_hand.soft? ? 's' : ' '} - #{dealer_hand}"

  # cash dispersal
  hands.each do |hand|
    result = HandComparison.call(player_hand: hand, dealer_hand: dealer_hand)

    case result
    when HandComparison::Results::PLAYER_WIN
      puts "WON : #{hand.value} - #{hand}"
      hand.owner.balance += hand.bet_amount * 2
    when HandComparison::Results::PLAYER_LOSS
      puts "LOST: #{hand.value} - #{hand}"
    when HandComparison::Results::PLAYER_BLACKJACK
      puts "BKJK: #{hand.value} - #{hand}"
      hand.owner.balance += hand.bet_amount * 2.5
    when HandComparison::Results::BLACKJACK_PUSH
      puts "BJPS: #{hand.value} - #{hand}"
      hand.owner.balance += hand.bet_amount
    when HandComparison::Results::TIE
      puts "TIE : #{hand.value} - #{hand}"
      hand.owner.balance += hand.bet_amount
    end
    # if hand.bust?
    #   puts "BUST: #{hand.value} - #{hand}"
    # elsif dealer_hand.bust? || hand.value > dealer_hand.value
    #   puts "WON : #{hand.value} - #{hand}"
    #   hand.owner.balance += hand.bet_amount * 2
    # elsif hand.value < dealer_hand.value
    #   puts "LOST: #{hand.value} - #{hand}"
    # else
    #   puts "TIE : #{hand.value} - #{hand}"
    #   hand.owner.balance += hand.bet_amount
    # end
  end

  puts "-------------------\n\n"
  # check if marker was seen
  # build new deck if it was
  next unless deck.count < 30

  deck = Deck.new
  (DECK_COUNT - 1).times do
    deck.merge(Deck.new)
  end
  deck.shuffle
end

players.each do |player|
  puts "Player finished with: #{player.balance}"
end
