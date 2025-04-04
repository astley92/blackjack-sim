# frozen_string_literal: true

RSpec.describe Hand do
  let(:hand) { described_class.new(owner: Player.new) }
  let(:cards) do
    [
      Deck::Card.new("A", "C"),
      Deck::Card.new("6", "C")
    ]
  end

  before do
    cards.each { hand.add_card(_1) }
  end

  describe ".value" do
    it "returns the hand value" do
      expect(hand.value).to eq(17)
    end

    context "when a hand contains an ace that should be counted as 1 value" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("6", "C"),
          Deck::Card.new("K", "C")
        ]
      end

      it "returns the hand value" do
        expect(hand.value).to eq(17)
      end
    end

    context "when a hand contains multiple aces with one that should be counted as 1 value" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("K", "C")
        ]
      end

      it "returns the hand value" do
        expect(hand.value).to eq(12)
      end
    end

    context "when a hand contains multiple aces but is still bust" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("K", "C"),
          Deck::Card.new("K", "C")
        ]
      end

      it "returns the hand value" do
        expect(hand.value).to eq(25)
      end
    end
  end

  describe ".soft?" do
    context "when the hand is a soft seventeen" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("6", "C")
        ]
      end

      it "returns true" do
        expect(hand.soft?).to eq(true)
      end
    end

    context "when the hand is soft" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("2", "C")
        ]
      end

      it "returns true" do
        expect(hand.soft?).to eq(true)
      end
    end

    context "when the hand is soft" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("K", "C")
        ]
      end

      it "returns true" do
        expect(hand.soft?).to eq(true)
      end
    end

    context "when the hand is soft" do
      let(:cards) do
        [
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("A", "C"),
          Deck::Card.new("5", "C")
        ]
      end

      it "returns true" do
        expect(hand.soft?).to eq(true)
      end
    end
  end
end
