# frozen_string_literal: true

RSpec.describe Deck do
  let(:deck) { described_class.new }

  it "initializes with all cards" do
    expect(deck.count).to eq(52)
    expect(deck.select { _1.suit == "H" }.count).to eq(13)
    expect(deck.select { _1.suit == "C" }.count).to eq(13)
    expect(deck.select { _1.suit == "S" }.count).to eq(13)
    expect(deck.select { _1.suit == "D" }.count).to eq(13)
  end

  describe ".merge" do
    subject(:merged_deck) do
      other_decks.each do |other_deck|
        deck.merge(other_deck)
      end
      deck
    end

    let(:other_decks) do
      [described_class.new, described_class.new]
    end

    it "adds all the cards" do
      expect(merged_deck.count).to eq(156)
    end

    context "when something other than a deck is attempted to be added" do
      before { other_decks << Player.new }

      it "raises an ArgumentError" do
        expect { merged_deck }.to raise_error(ArgumentError)
      end
    end
  end
end
