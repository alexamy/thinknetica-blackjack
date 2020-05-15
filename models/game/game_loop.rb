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

  def ask_turn
    # TODO show only pass / end if 3 cards
    puts 'Your turn (1 pass, 2 add, 3 end):'
    choice = gets.chomp.to_i
    raise unless [1, 2, 3].include?(choice)

    %i[pass add end][choice - 1]
  rescue StandardError
    retry
  end

  def dealer_turn
    dealer = players[:dealer]
    dealer.add!(deck.get!) if rules.hand_value(dealer.cards) < 17
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
