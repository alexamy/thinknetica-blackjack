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

    def get_input(message)
      print("#{message.capitalize}: ")
      result = gets.chomp
      puts
      result
    end

    def ask_new_session
      choice = get_input('start new session? (n - no)')
      raise NewGame.new unless choice.start_with?('n')
    end

    def ask_choice_for(options)
      choice = get_input("your choice (#{options.join(', ')})")
      result = options.find { |opt| opt.to_s.start_with?(choice) }
      raise if choice.empty? || !result

      result
    end

    def self.intro
      'Welcome to blackjack game! When answering questions, ' \
      'you can type first letter(s) of option.' \
    end
  end
end
