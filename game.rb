# main class
class Game
  include GameInitializer
  include GameLoop

  attr_reader_writer :rules, :name, :bank, :deck, :player, :dealer

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

  def show_ui
    puts bank.dealer
    puts dealer, "\n"

    puts bank.pool, "\n"

    puts bank.player
    puts "#{player} #{hand_value(player)}"
  end

  def hand_value(cards)
    sum = 0
    "Σ #{sum}"
  end
end
