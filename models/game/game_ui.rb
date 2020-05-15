# show game info
module GameUI
  def show_ui
    system('clear')
    show_dealer
    show_bank
    show_player
  end

  def show_dealer
    puts bank.dealer
    puts dealer, "\n"
  end

  def show_bank
    puts bank.pool, "\n"
  end

  def show_player
    puts player
    puts "#{bank.player} #{hand_value(player.cards)}", "\n"
  end
end
