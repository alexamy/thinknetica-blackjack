module Game
  # ui for game
  module UI
    def show_ui
      players.each { |player| puts player, "\n" }
      puts "Bank #{pool}$", "\n"
    end

    # :reek:TooManyStatements
    def end_session
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

    # :reek:TooManyStatements
    def ask_choice_for(options)
      print "Your choice (#{options.join(', ')}): "
      choice = gets.chomp
      puts
      result = options.find { |opt| opt.to_s.start_with?(choice) }
      raise unless result

      result
    end

    protected

    def congrats
      {
        draw: 'Draw!',
        user: 'You win!',
        dealer: 'You lose!'
      }
    end
  end
end
