# frozen_string_literal: true

class App
  class Logger
    def debug(message)
      return unless @log_level == :debug

      puts("LEVEL: DEBUG, MSG: #{message}")
    end

    private

    def initialize(log_level:)
      @log_level = log_level.to_sym
    end
  end
end
