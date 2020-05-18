module Game
  # ui for game
  module UI
    def show_ui
      players.each { |player| puts player, "\n" }
      puts "Bank #{pool}$", "\n"
    end

    def show_session_congrat
      congrats = {
        draw: 'Draw!',
        user: 'You win!',
        dealer: 'You lose!'
      }
      puts congrats[game_result]
    end

    def show_end_congrat
      puts user.money > dealer.money ? 'You win!' : 'You lose!'
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
  end
end
