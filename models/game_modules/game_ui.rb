module Game
  # ui for game
  module UI
    def show_ui(mode = :only_user)
      user = self.user.show
      dealer = self.dealer.show

      puts user, "\n"
      puts dealer, "\n"
      puts "Bank #{pool}$", "\n"
    end

    def show_result
      case game_result
      when :draw
        puts 'Draw!'
        players.each { |player| player.add_money(pool / 2) }
      when :user
        puts 'You win!'
        user.add_money(pool)
      else
        puts 'You lose!'
        dealer.add_money(pool)
      end
      self.pool = 0
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
