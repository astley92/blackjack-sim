# frozen_string_literal: true

RSpec.describe HandComparison do
  subject(:result) { described_class.call(dealer_hand: dealer_hand, player_hand: player_hand) }
  let(:dealer_hand) { Hand.new(owner: Player.new(strategy: nil)) }
  let(:player_hand) { Hand.new(owner: Player.new(strategy: nil)) }

  before do
    player_cards.each { player_hand.add_card(_1) }
    dealer_cards.each { dealer_hand.add_card(_1) }
  end

  context "when the player wins" do
    let(:player_cards) { [Deck::Card.new("K", "C"), Deck::Card.new("Q", "D")] }
    let(:dealer_cards) { [Deck::Card.new("7", "C"), Deck::Card.new("Q", "D")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::PLAYER_WIN)
    end
  end

  context "when the dealer wins" do
    let(:player_cards) { [Deck::Card.new("6", "C"), Deck::Card.new("Q", "D")] }
    let(:dealer_cards) { [Deck::Card.new("7", "C"), Deck::Card.new("Q", "D")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::PLAYER_LOSS)
    end
  end

  context "when there is a tie" do
    let(:player_cards) { [Deck::Card.new("7", "C"), Deck::Card.new("Q", "D")] }
    let(:dealer_cards) { [Deck::Card.new("7", "C"), Deck::Card.new("Q", "D")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::TIE)
    end
  end

  context "when the player has blackjack" do
    let(:player_cards) { [Deck::Card.new("A", "C"), Deck::Card.new("Q", "D")] }
    let(:dealer_cards) { [Deck::Card.new("7", "C"), Deck::Card.new("Q", "D")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::PLAYER_BLACKJACK)
    end
  end

  context "when both have blackjack" do
    let(:player_cards) { [Deck::Card.new("A", "C"), Deck::Card.new("Q", "D")] }
    let(:dealer_cards) { [Deck::Card.new("A", "C"), Deck::Card.new("Q", "D")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::BLACKJACK_PUSH)
    end
  end

  context "when the player has bust" do
    let(:player_cards) { [Deck::Card.new("6", "C"), Deck::Card.new("Q", "D"), Deck::Card.new("K", "C")] }
    let(:dealer_cards) { [Deck::Card.new("A", "C"), Deck::Card.new("9", "D")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::PLAYER_LOSS)
    end
  end

  context "when the dealer has bust" do
    let(:player_cards) { [Deck::Card.new("A", "C"), Deck::Card.new("9", "D")] }
    let(:dealer_cards) { [Deck::Card.new("6", "C"), Deck::Card.new("Q", "D"), Deck::Card.new("K", "C")] }

    it "returns the expected result" do
      expect(result).to eq(HandComparison::Results::PLAYER_WIN)
    end
  end
end
