# Main entry
class Game
  attr_reader_writer :deck, :players, :pool

  START_MONEY = 100

  def initialize
    @players = {
      user: Player.new(START_MONEY),
      dealer: Player.new(START_MONEY)
    }
  end

  def run
    init_session
    show_ui
    ask_choice
  end

  def init_session
    self.deck = Deck.new
    @players.each_value(&:throw_cards)
    2.times { @players.each_value { |player| player.add_card(deck.get) } }
    self.pool = @players.values.map { |player| player.get_money(10) }.sum
  end

  def show_ui
    players.each do |name, player|
      cards = player.cards

      cards_str = cards.map(&:to_s).join(' ').ljust(10, ' ')
      points = "Σ #{Card.points(cards)}".ljust(2, ' ')
      name = name.to_s.rjust(8, ' ')
      money = "#{player.money}$".ljust(3, ' ')

      puts [cards_str, points, name, money].join(' '), "\n"
    end
    puts "Bank #{pool}$", "\n"
  end

  def ask_choice
    gets
  end
end
