# show game info
module GameUI
  def show_ui
    system('clear')
    show_dealer
    puts
    show_bank
    puts
    show_player
  end

  def show_dealer
    puts bank.dealer
    puts dealer
  end

  def show_bank
    puts bank.pool
  end

  def show_player
    puts player
    puts "#{bank.player} #{hand_value(player)}"
  end
end
