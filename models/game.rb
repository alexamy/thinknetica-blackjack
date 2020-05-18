module Game
  # Main entry
  class Runner
    include Rules
    include Initializer
    include Loop
    include UI
    include PlayerPrint

    attr_reader_writer :deck, :players, :pool, :flags, :show_dealer

    def initialize
      init_players
      dealer.visible = false
    end

    def ask_choice
      options = %i[end pass add]
      options.delete(:add) if user.cards.length > 2
      begin
        ask_choice_for(options)
      rescue StandardError
        retry
      end
    end

    # :reek:ControlParameter
    def user_turn(choice)
      case choice
      when :add
        user.cards.add(deck.get)
      when :end
        raise EndSession.new
      end
    end

    def check_cards_count
      cards_enough = players.all? { |player| player.cards.length >= 3 }
      raise EndSession.new if cards_enough
    end
  end
end
