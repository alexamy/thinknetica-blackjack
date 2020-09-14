# frozen_string_literal: true

require_relative 'extensions/hash.rb'
require_relative 'extensions/class.rb'
require_relative 'models/modules/card_constants.rb'
require_relative 'models/modules/player_print.rb'
require_relative 'models/game_modules/game_loop.rb'
require_relative 'models/game_modules/game_initializer.rb'
require_relative 'models/game_modules/game_ui.rb'
require_relative 'models/game_modules/game_rules.rb'
require_relative 'models/card/card.rb'
require_relative 'models/card/deck.rb'
require_relative 'models/player.rb'
require_relative 'models/events.rb'
require_relative 'models/game.rb'

puts Game::UI.intro, "\n"
Game::Runner.new.run
