# Main entry
class Game
  attr_reader_writer :deck, :players, :pool, :flags

  START_MONEY = 100

  def initialize
    @players = {
      user: Player.new(START_MONEY),
      dealer: Player.new(START_MONEY)
    }
    @flags = {
      end_game: false,
      end_session: false
    }
  end

  def run
    init_session
    loop do
      show_ui
      user_turn(ask_choice)
      dealer_turn
    end
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
      name = name.to_s.rjust(7, ' ')
      money = "#{player.money}$".ljust(3, ' ')

      puts [cards_str, points, name, money].join(' '), "\n"
    end
    puts "Bank #{pool}$", "\n"
  end

  def ask_choice
    options = %i[end pass add]
    options.delete!(:add) if players[:user].cards.length > 2

    begin
      puts "Your choice (#{options.join(', ')}):"
      choice = gets.chomp
      result = options.find { |opt| opt.to_s.start_with?(choice) }
      raise unless result
      result
    rescue StandardError
      retry
    end
  end

  def user_turn(choice)
    player = players[:user]
    case choice
    when :add
      player.add_card(deck.get)
    when :end
      flags[:end_session] = true
    end
  end

  def dealer_turn
    player = players[:dealer]
    points = Card.points(player.cards)
    player.add_card(deck.get) if points < 17 && player.cards.length < 3
  end
end
