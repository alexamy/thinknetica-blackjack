# main class
class Game
  include GameUI
  include GameInitializer
  include GameLoop

  attr_reader_writer :rules, :name, :bank, :deck, :players

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
    # show winner
  end

  def hand_value(cards)
    "Σ#{rules.hand_value(cards)}"
  end
end
