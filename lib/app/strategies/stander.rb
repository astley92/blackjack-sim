# frozen_string_literal: true

class App
  module Strategies
    module Stander
      def self.decision(hand, dealer_card)
        App::PlayerActions::STAND
      end
    end
  end
end
