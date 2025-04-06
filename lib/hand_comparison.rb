# frozen_string_literal: true

module HandComparison
  module Results
    PLAYER_WIN = :player_win
    PLAYER_LOSS = :player_loss
    PLAYER_BLACKJACK = :player_blackjack
    BLACKJACK_PUSH = :blackjack_push
    TIE = :tie
  end

  def self.call(player_hand:, dealer_hand:)
    if player_hand.blackjack? && dealer_hand.blackjack?
      return Results::BLACKJACK_PUSH
    elsif player_hand.blackjack?
      return Results::PLAYER_BLACKJACK
    elsif player_hand.bust?
      return Results::PLAYER_LOSS
    elsif dealer_hand.bust? || player_hand.value > dealer_hand.value
      return Results::PLAYER_WIN
    elsif player_hand.value == dealer_hand.value
      return Results::TIE
    end

    Results::PLAYER_LOSS
  end
end
