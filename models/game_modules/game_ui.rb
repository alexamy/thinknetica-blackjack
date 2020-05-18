module Game
  # ui for game
  module UI
    def show_ui(show_dealer = false)
      user = show_player(self.user)
      dealer = show_player(self.dealer, show_dealer)

      puts user, "\n"
      puts dealer, "\n"
      puts "Bank #{pool}$", "\n"
    end

    # :reek:TooManyStatements
    def show_player(player, visible = true)
      cards_arr = player.cards

      cards  = show_cards(cards_arr, visible)
      points = show_points(cards_arr, visible)
      name   = show_name(player.name)
      money  = show_money(player.money)

      [cards, points, name, money].join(' ')
    end

    def show_result
      user = Card.points(self.user.cards)
      dealer = Card.points(self.dealer.cards)

      draw = (user > 21 && dealer > 21) || (user == dealer)
      user_win = (user > dealer && user < 21 && dealer < 21) || dealer > 21

      if draw
        puts "Draw!"
        players.each { |player| player.add_money(pool / 2) }
      elsif user_win
        puts "You win!"
        self.user.add_money(pool)
      else
        puts "You lose!"
        self.dealer.add_money(pool)
      end
      self.pool = 0
    end

    def show_end_congrat
      user = self.user.money
      dealer = self.dealer.money
      puts user > dealer ? "You win!" : "You lose!"
    end

    def ask_new_session
      print 'Start new session? (n - no): '
      choice = gets.chomp
      puts
      raise NewGame.new unless choice.start_with?('n')
    end

    protected

    def show_cards(cards, visible)
      cards.map { |card| visible ? card.to_s.ljust(3, ' ') : 'XXX' }
          .join(' ')
          .ljust(12, ' ')
    end

    def show_points(cards, visible)
      points = "Σ #{Card.points(cards)}".ljust(4, ' ')
      points = points.gsub(/./, ' ') unless visible
      points
    end

    def show_name(name)
      name.to_s.rjust(7, ' ')
    end

    def show_money(money)
      "#{money}$".ljust(4, ' ')
    end
  end
end
