# frozen_string_literal: true

class App
  class Logger
    def self.set_level(level)
      @log_level = level
    end

    def self.debug(message)
      return unless @log_level == :debug

      puts("LEVEL: DEBUG, MSG: #{message}")
    end
  end
end
