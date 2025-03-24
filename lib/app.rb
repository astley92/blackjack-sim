# frozen_string_literal: true

require_relative("app/seat")
require_relative("app/dealer")
require_relative("app/player")
require_relative("app/hand")
require_relative("app/hand_calculator")
require_relative("app/strategies/random")
require_relative("app/strategies/stander")

class App
  module PlayerActions
    HIT = :hit
    STAND = :stand
  end

  def initialize(target_hand_count:)
    @hand_count = 0
    @target_hand_count = target_hand_count
    # TODO: Pass deck config (deck count, penetration, etc)
    @dealer = App::Dealer.new
    @house_bank = 100_000_00
  end

  def run
    # TODO: Create some different player strategies
    seats = [
      App::Seat.new(player: App::Player.new(name: "Random", strategy: App::Strategies::Random)),
      App::Seat.new(player: App::Player.new(name: "Stander", strategy: App::Strategies::Stander))
    ]

    while running?
      @hand_count += 1
      # TODO: Write to file
      App::Logger.debug("Playing hand ##{@hand_count}")

      # Reset cards and place bets
      seats.each do |seat|
        seat.reset(App::Hand.new)
        seat.bet_amount = seat.player.place_bet
      end
      dealer_hand = App::Hand.new
      @dealer.start_hand

      # Deal initial cards
      2.times do
        seats.each do |seat|
          seat.hand += @dealer.deal
        end
        dealer_hand += @dealer.deal
      end

      # Player action
      # TODO: Allow double, split, insurance, surrender
      seats.each do |seat|
        while true
          seat.score = App::HandCalculator.call(seat.hand)
          App::Logger.debug("#{seat.player} has #{seat.score} (#{seat.hand})")

          if seat.bust?
            App::Logger.debug("#{seat.player} bust!")
            break
          end

          player_action = seat.player.next_action(seat.score, dealer_hand[0])
          if player_action == PlayerActions::STAND
            App::Logger.debug("#{seat.player} has stood")
            break
          end

          App::Logger.debug("#{seat.player} hits!")
          seat.hand += @dealer.deal
        end
      end

      # Dealer action
      App::Logger.debug("---------")
      dealer_score = App::HandCalculator.call(dealer_hand)
      App::Logger.debug("Dealer shows - #{dealer_hand} for #{dealer_score}")

      unless seats.all?(&:bust?)
        # TODO: Handle soft 17
        while dealer_score.value < 17
          dealer_hand += @dealer.deal
          dealer_score = App::HandCalculator.call(dealer_hand)
          App::Logger.debug("Dealer draws to #{dealer_score}")
        end
      end

      # Money dispersion
      seats.each do |seat|
        if seat.bust?
          App::Logger.debug("Player #{seat.player} busts and loses #{seat.bet_amount}")
          @house_bank += seat.bet_amount
          next
        end

        if seat.score == dealer_score
          App::Logger.debug("Player #{seat.player} ties with dealer")
          seat.player.bank += seat.bet_amount
          next
        end

        if seat.score > dealer_score
          App::Logger.debug("Player #{seat.player} beats dealer and wins #{seat.bet_amount}")
          @house_bank -= seat.bet_amount
          seat.player.bank += seat.bet_amount * 2
          next
        end

        App::Logger.debug("Player #{seat.player} loses #{seat.bet_amount} on count to dealer")
        @house_bank += seat.bet_amount
      end

      # Log money levels
      App::Logger.debug("House bank $#{@house_bank}")
      seats.each do |seat|
        App::Logger.debug("#{seat.player} bank $#{seat.player.bank}")
      end

      App::Logger.debug("---------\n\n")
    end
  end

  private

  def running?
    @hand_count < @target_hand_count
  end
end
