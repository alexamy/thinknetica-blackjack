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
    2.times { @players.each_value { |player| player.add_card(deck.get) } }
    self.pool = @players.values.map { |player| player.get_money(10) }.sum
  end

  def show_ui
  end

  def ask_choice
  end
end
