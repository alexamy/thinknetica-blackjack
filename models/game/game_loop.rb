# Main game loop
module GameLoop
  def game_loop
    loop do
      return if game_end?

      init_session
      session_loop
    end
  end

  def session_loop
    loop do
      show_ui
      player_turn
      dealer_turn
      return if end_session?
    end
  end

  def player_turn
    # ask player what to do
  end

  def dealer_turn
    # ai decision what to do
  end

  def game_end?
    # end game, if one of the players have 0 money
  end

  def end_session?
    # should game session end?
  end
end
