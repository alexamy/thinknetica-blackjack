# main class
class Game
  include GameInitializer
  include GameLoop

  attr_reader_writer :rules, :name, :bank, :deck, :player, :dealer

  def initialize(rules)
    @rules = rules
    @name = 'Anonymous'
    @bank = Bank.new(rules.start_money)
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
    puts "#{bank.dealer} #{dealer}", "\n"
    puts "#{bank.pool} #{deck.top_card}", "\n"
    puts "#{bank.player} #{player}"
  end

  def hand_value(cards)
    # determine hand cards values sum
  end
end
