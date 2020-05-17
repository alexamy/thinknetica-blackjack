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
      cards_str = cards.map(&:to_s).join(' ')

      cards_row = "#{cards_str}  Σ #{Card.points(cards)}"
      bank_row = "#{name.to_s.capitalize} #{player.money}$"

      puts "#{cards_row} #{bank_row}", "\n"
    end
    puts "Bank #{pool}$", "\n"
  end

  def ask_choice
    gets
  end
end
