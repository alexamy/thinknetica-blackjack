# Main game loop
module GameLoop
  def game_loop
    loop do
      return if game_end?

      self.session_end_flag = false
      init_session
      session_loop
    end
  end

  def session_loop
    loop do
      show_ui
      return if end_session?

      user_turn(ask_turn)
      dealer_turn
    end
  end

  # :reek:ControlParameter
  def user_turn(choice)
    case choice
    when :add
      players[:user].add!(deck.get!)
    when :end
      set_end_game
    end
  end

  def ask_turn
    puts 'Your turn (1 pass, 2 add, 3 end):'
    choice = gets.chomp.to_i
    raise unless [1, 2, 3].include?(choice)

    %i[pass add end][choice - 1]
  rescue StandardError
    retry
  end

  def dealer_turn
    dealer = players[:dealer]
    dealer.add!(deck.get!) if hand_value(dealer.cards) < 17
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
    session_end_flag || card_count
  end
end
