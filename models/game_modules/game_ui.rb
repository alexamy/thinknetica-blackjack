# ui for game
module GameUI
  def show_ui(show_dealer = false)
    user = show_player(self.user)
    dealer = show_player(self.dealer, show_dealer)

    puts user, "\n"
    puts dealer, "\n"
    puts "Bank #{pool}$", "\n"
  end

  def show_player(player, visible = true)
    cards = player.cards
    cards_str = cards.map { |card| visible ? card.to_s.ljust(3, ' ') : 'XXX' }
    cards_str = cards_str.join(' ').ljust(12, ' ')

    points = "Σ #{Card.points(cards)}".ljust(4, ' ')
    points = points.gsub(/./, ' ') unless visible

    name = player.name.to_s.rjust(7, ' ')
    money = "#{player.money}$".ljust(4, ' ')

    result = [cards_str, points, name, money]
    result.join(' ')
  end

  def show_result
    user = Card.points(self.user.cards)
    dealer = Card.points(self.dealer.cards)

    draw = (user > 21 && dealer > 21) || (user == dealer)
    user_win = (user > dealer && user < 21 && dealer < 21) || dealer > 21

    if draw
      puts "Draw!"
      players.each { |player| player.add_money(pool / 2) }
    elsif user_win
      puts "You win!"
      self.user.add_money(pool)
    else
      puts "You lose!"
      self.dealer.add_money(pool)
    end
    self.pool = 0
  end

  def show_end_congrat
    user = self.user.money
    dealer = self.dealer.money
    puts user > dealer ? "You win!" : "You lose!"
  end

  def ask_new_session
    print 'Start new session? (n - no): '
    choice = gets.chomp
    puts
    raise NewGame.new unless choice.start_with?('n')
  end
end
