# frozen_string_literal: true

require("byebug")
require_relative("lib/app")
require_relative("lib/app/logger")

App::Logger.set_level(:debug)

app = App.new(
  target_hand_count: 10_000
)
app.run
