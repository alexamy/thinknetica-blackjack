# frozen_string_literal: true

require_relative 'extensions/require_all.rb'
require_all '.'

Game::Runner.new.run
