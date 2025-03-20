# frozen_string_literal: true

RSpec.describe Deck::Card do
  let(:card) { Deck::Card.new("A", "H") }

  describe ".to_s" do
    subject(:string) { card.to_s }

    it { is_expected.to eq("AH") }
  end
end
