# frozen_string_literal: true

require_relative("boot")

HAND_COUNT = 10_000
DECK_COUNT = 2

deck = Deck.new
(DECK_COUNT - 1).times do
  deck.merge(Deck.new)
end
deck.shuffle

dealer = Player.new(strategy: Strategies::StandardDealer)
players = []
players << Player.new(strategy: Strategies::StandardPlayer)
players << Player.new(strategy: Strategies::DoublePlayer)
players << Player.new(strategy: Strategies::SplitPlayer)

HAND_COUNT.times do |i|
  puts "--- HAND #{i + 1} ---"
  # place bets
  dealer_hand = Hand.new(owner: dealer)
  hands = players.map do |player|
    player.balance -= player.bet_amount
    Hand.new(owner: player, bet_amount: player.bet_amount)
  end
  played_hands = []

  # deal initial cards
  2.times do
    hands.each { _1.add_card(deck.shift) }
    dealer_hand.add_card(deck.shift)
  end

  if dealer_hand.blackjack?
    played_hands = hands
  else
    # player actions
    while hands.any?
      hand = hands.shift
      loop do
        if hand.bust?
          played_hands << hand
          break
        end
        if hand.count == 1
          hand.add_card(deck.shift)
          next
        end

        action = hand.owner.next_action(hand, {})
        case action
        when Actions::STAND
          played_hands << hand
          break
        when Actions::DOUBLE
          puts "PLAYER DOUBLING"
          hand.owner.balance -= hand.bet_amount
          hand.bet_amount += hand.bet_amount
          hand.add_card(deck.shift)
          played_hands << hand
          break
        when Actions::HIT
          hand.add_card(deck.shift)
        when Actions::SPLIT
          puts "PLAYER SPLITTING"
          hand.cards.each do |card|
            hand.owner.balance -= hand.bet_amount
            new_hand = Hand.new(owner: hand.owner, bet_amount: hand.bet_amount)
            new_hand.add_card(card)
            hands.unshift(new_hand)
          end
          break
        else
          raise NotImplementedError, "unkown action #{action}"
        end
      end
    end

    # dealer actions
    unless played_hands.all?(&:bust?)
      dealer_hand.add_card(deck.shift) while !dealer_hand.bust? && dealer.next_action(dealer_hand, {}) != Actions::STAND
    end
  end

  puts "Dealer has: #{dealer_hand.value}#{dealer_hand.soft? ? 's' : ' '} - #{dealer_hand}"

  # cash dispersal
  played_hands.each do |played_hand|
    result = HandComparison.call(player_hand: hand, dealer_hand: dealer_hand)

    case result
    when HandComparison::Results::PLAYER_WIN
      puts "WON : #{played_hand.value} - #{played_hand}"
      played_hand.owner.balance += played_hand.bet_amount * 2
    when HandComparison::Results::PLAYER_LOSS
      puts "LOST: #{played_hand.value} - #{played_hand}"
    when HandComparison::Results::PLAYER_BLACKJACK
      puts "BKJK: #{played_hand.value} - #{played_hand}"
      played_hand.owner.balance += played_hand.bet_amount * 2.5
    when HandComparison::Results::BLACKJACK_PUSH
      puts "BJPS: #{played_hand.value} - #{played_hand}"
      played_hand.owner.balance += played_hand.bet_amount
    when HandComparison::Results::TIE
      puts "TIE : #{played_hand.value} - #{played_hand}"
      played_hand.owner.balance += played_hand.bet_amount
    end
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
  puts "#{player.strategy.name.ljust(20, ' ')} finished with: #{player.balance}"
end
