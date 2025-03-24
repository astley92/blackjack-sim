# frozen_string_literal: true

class App
  module Strategies
    module Random
      def self.decision(hand, dealer_card)
        [1, 2].shuffle[0] == 1 ? App::PlayerActions::HIT : App::PlayerActions::STAND
      end
    end
  end
end
