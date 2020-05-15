# Main game loop
module GameLoop
  def game_loop
    loop do
      return if game_end?

      self.session_end_flag = false
      init_session
      session_loop

      is_repeat = ask_another_game
      return if is_repeat == 'n'
    end
  end

  def session_loop
    loop do
      show_ui
      if end_session?
        show_results
        return
      end

      user_turn(ask_turn)
      dealer_turn
    end
  end

  def ask_another_game
    puts 'Do you want to continue? (n - no)'
    gets.chomp.downcase
  end

  # :reek:ControlParameter
  def user_turn(choice)
    case choice
    when :add
      card = deck.get!
      card.show
      players[:user].add!(card)
    when :end
      set_end_game
    end
  end

  # TODO refactor
  def ask_turn
    options = %i[pass add end]
    options.delete(:add) if players[:user].cards.length == 3

    options_msg = options
                  .map.with_index { |opt, idx| "#{idx} - #{opt}" }
                  .join(', ')

    puts "Your turn (#{options_msg}) :"
    choice = gets.chomp.to_i
    raise unless options[choice]

    options[choice]
  rescue StandardError
    retry
  end

  def dealer_turn
    dealer = players[:dealer]
    can_add = rules.hand_value(dealer.cards) < 17 && dealer.cards.length < 3
    dealer.add!(deck.get!) if can_add
  end

  def show_results
    # TODO
  end

  def set_end_game
    self.session_end_flag = true
    players[:dealer].cards.each(&:show)
  end

  def game_end?
    bank.accounts.values.any? { |account| account.amount.zero? }
  end

  def end_session?
    card_count = players.values.all? { |player| player.cards.length == 3 }
    card_count || session_end_flag
  end
end
