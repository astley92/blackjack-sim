# frozen_string_literal: true

RSpec.describe Deck do
  subject(:deck) { described_class.new }

  it "initializes with all cards" do
    expect(deck.count).to eq(52)
    expect(deck.select { _1.suit == "H" }.count).to eq(13)
    expect(deck.select { _1.suit == "C" }.count).to eq(13)
    expect(deck.select { _1.suit == "S" }.count).to eq(13)
    expect(deck.select { _1.suit == "D" }.count).to eq(13)
  end
end
