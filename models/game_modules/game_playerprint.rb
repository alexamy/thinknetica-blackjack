module Game
  # print player data
  module PlayerPrint
    # :reek:TooManyStatements
    def show_player(player, visible = true)
      cards_arr = player.cards

      cards  = show_cards(cards_arr, visible)
      points = show_points(cards_arr, visible)
      name   = show_name(player.name)
      money  = show_money(player.money)

      [cards, points, name, money].join(' ')
    end

    protected

    # :reek:UtilityFunction, :reek:ControlParameter
    def show_cards(cards, visible)
      cards.map { |card| visible ? card.to_s.ljust(3, ' ') : 'XXX' }
           .join(' ')
           .ljust(12, ' ')
    end

    # :reek:UtilityFunction, :reek:ControlParameter
    def show_points(cards, visible)
      points = "Σ #{Card.points(cards)}".ljust(4, ' ')
      points = points.gsub(/./, ' ') unless visible
      points
    end

    # :reek:UtilityFunction
    def show_name(name)
      name.to_s.rjust(7, ' ')
    end

    # :reek:UtilityFunction
    def show_money(money)
      "#{money}$".ljust(4, ' ')
    end
  end
end
