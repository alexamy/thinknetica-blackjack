# main class
class Game
  include Rules
  include GameInitializer
  include GameLoop

  attr_reader_writer :name, :bank, :deck, :player, :dealer

  def initialize
    @name = 'Anonymous'
    @bank = Bank.new(START_MONEY)
  end

  def run
    ask_name
    game_loop
    show_game_results
  end

  def ask_name
    puts 'What is your name?'
    name = gets.chomp
    self.name = name unless name.empty?
  end

  def show_game_results
    # show winner
  end

  def show_ui
    # render ui
  end
end
