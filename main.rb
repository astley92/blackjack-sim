# frozen_string_literal: true

require("byebug")
require_relative("./lib/app")
require_relative("./lib/app/logger")

app = App.new(
  target_hand_count: 200,
  logger: App::Logger.new(log_level: :debug),
)
app.run
