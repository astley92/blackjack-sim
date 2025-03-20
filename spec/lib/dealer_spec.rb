# frozen_string_literal: true

RSpec.describe Dealer do
  let(:dealer) { Dealer.new }
  let(:deck) { Deck.new }

  before { dealer.deck = deck }

  describe ".deal" do
    it "deals a card from the prepared deck" do
      expect { dealer.deal }.to change { deck.count }.from(52).to(51)
    end
  end
end
