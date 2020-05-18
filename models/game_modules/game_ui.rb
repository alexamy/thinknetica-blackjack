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
      prize = pool / 2
      self.pool = 0

      players.each { |player| player.add_money(prize) }
      user.add_money(prize) if result == :user
      dealer.add_money(prize) if result == :dealer

      puts congrats[result]
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
      user = self.user.cards.points
      dealer = self.dealer.cards.points
      return :draw if Rules.draw?(user, dealer)
      return :user if Rules.user_win?(user, dealer)

      :dealer
    end
  end
end
