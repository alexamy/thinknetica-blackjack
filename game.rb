# Main entry
class Game
  attr_reader_writer :players

  START_MONEY = 100

  def initialize
    @players = {
      user: Player.new(:user, START_MONEY),
      dealer: Player.new(:dealer, START_MONEY)
    }
  end

  def run
    show_ui
    ask_choice
  end

  def show_ui
  end

  def ask_choice
  end
end
