# frozen_string_literal: true

require("byebug")
require_relative("./lib/app")

app = App.new(
  target_hand_count: 200,
)
app.run
