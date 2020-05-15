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
      self.session_end_flag = true
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
    # ai decision what to do
  end

  def game_end?
    # end game, if one of the players have 0 money
  end

  def end_session?
    session_end_flag || players.all? { |player| player.cards.length == 3 }
  end
end
