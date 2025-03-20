# frozen_string_literal: true

class App
  def initialize(target_hand_count:, logger: MyApp::Logger.new)
    @hand_count = 0
    @target_hand_count = target_hand_count
    @logger = logger
  end

  def run
    while running?
      @hand_count += 1

      @logger.debug("Playing hand ##{@hand_count}")
    end
  end

  private

  def running?
    @hand_count < @target_hand_count
  end
end
