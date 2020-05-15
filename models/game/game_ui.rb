# show game info
module GameUI
  def show_ui
    system('clear')
    show_player(:dealer, session_end_flag)
    show_bank
    show_player(:user, true)
  end

  # :reek:ControlParameter
  def show_player(key, visible = false)
    player = players[key]
    puts bank.accounts[key]
    print player
    print " #{hand_value(player.cards)}" if visible
    puts "\n\n"
  end

  def show_bank
    puts bank.pool, "\n"
  end
end
