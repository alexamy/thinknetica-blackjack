# rubocop:disable all
# :reek:all
# Main entry
module Game
  class Runner
    include Initializer
    include Loop
    include UI
    include PlayerPrint

    attr_reader_writer :deck, :players, :pool, :flags, :show_dealer

    def initialize
      init_players
    end

    def ask_choice
      options = %i[end pass add]
      options.delete(:add) if user.cards.length > 2

      begin
        print "Your choice (#{options.join(', ')}): "
        choice = gets.chomp
        puts
        result = options.find { |opt| opt.to_s.start_with?(choice) }
        raise unless result
        result
      rescue StandardError
        retry
      end
    end

    def user_turn(choice)
      case choice
      when :add
        user.add_card(deck.get)
      when :end
        raise EndSession.new
      end
    end

    def dealer_turn
      cards = dealer.cards
      points = Card.points(cards)
      dealer.add_card(deck.get) if points < 17 && cards.length < 3
    end

    def check_cards_count
      cards_enough = players.all? { |player| player.cards.length >= 3 }
      raise EndSession.new if cards_enough
    end
  end
end
