# frozen_string_literal: true

require_relative 'models/card.rb'
require_relative 'models/card_hand.rb'
require_relative 'models/bank.rb'
require_relative 'models/deck.rb'
require_relative 'models/player.rb'
require_relative 'modules/game_initializer.rb'
require_relative 'game.rb'

Game.new.run
