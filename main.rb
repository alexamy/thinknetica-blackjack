# frozen_string_literal: true

require_relative 'require_all.rb'
require_all '.'

game = Game.new(Rules.new)
game.run
