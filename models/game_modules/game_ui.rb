module Game
  # ui for game
  module UI
    def show_ui
      players.each { |player| puts player, "\n" }
      puts "Bank #{pool}$", "\n"
    end

    # :reek:TooManyStatements
    def show_result
      result = game_result
      puts congrats[result]

      prize = pool / 2
      self.pool = 0

      players.each { |player| player.add_money(prize) }
      user.add_money(prize) if result == :user
      dealer.add_money(prize) if result == :dealer
    end

    def show_end_congrat
      user = self.user.money
      dealer = self.dealer.money
      puts user > dealer ? 'You win!' : 'You lose!'
    end

    def ask_new_session
      print 'Start new session? (n - no): '
      choice = gets.chomp
      puts
      raise NewGame.new unless choice.start_with?('n')
    end

    protected

    def congrats
      {
        draw: 'Draw!',
        user: 'You win!',
        dealer: 'You lose!'
      }
    end

    def game_result
      user = Card.points(self.user.cards)
      dealer = Card.points(self.dealer.cards)
      return :draw if draw?(user, dealer)
      return :user if user_win?(user, dealer)

      :dealer
    end

    # :reek:UtilityFunction
    def draw?(user, dealer)
      (user > 21 && dealer > 21) || (user == dealer)
    end

    # :reek:UtilityFunction
    def user_win?(user, dealer)
      (user > dealer && user < 21 && dealer < 21) || dealer > 21
    end
  end
end
