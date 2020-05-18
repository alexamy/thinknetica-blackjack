# frozen_string_literal: true

require_relative 'extensions/require_all.rb'
require_all '.'

puts Game::UI.intro, "\n"
Game::Runner.new.run
