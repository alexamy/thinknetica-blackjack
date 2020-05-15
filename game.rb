# main class
class Game
  include GameUI
  include GameInitializer
  include GameLoop

  attr_reader_writer :rules, :name, :bank, :deck, :players, :session_end_flag

  def initialize(rules)
    @rules = rules
  end

  def run
    ask_name
    init_bank

    game_loop
    show_game_results
  end

  def ask_name
    begin
      puts 'What is your name?'
      name = gets.chomp
      raise if name.empty?
    rescue StandardError
      retry
    end
    self.name = name
  end

  def show_game_results
    'Game end!'
  end
end
