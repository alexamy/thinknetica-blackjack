# rubocop:disable all
# :reek:all
# Main entry
class Game
  attr_reader_writer :deck, :players, :pool, :flags, :show_dealer

  START_MONEY = 100

  def initialize
    @players = {
      user: Player.new(START_MONEY),
      dealer: Player.new(START_MONEY)
    }
  end

  def run
    loop do
      begin
        session_loop
        ask_new_session
      rescue EndGame
        return
      end
    end
  end

  def session_loop
    init_session
    loop do
      begin
        show_ui
        user_turn(ask_choice)
        dealer_turn
        check_cards_count
      rescue EndSession
        show_result
        show_ui(true)
        return
      end
    end
  end

  def init_session
    self.deck = Deck.new
    @players.each_value(&:throw_cards)
    2.times { @players.each_value { |player| player.add_card(deck.get) } }
    self.pool = @players.values.map { |player| player.get_money(10) }.sum
  end

  ## TODO show_dealer = true
  def show_ui(show_dealer = false)
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
    options.delete(:add) if players[:user].cards.length > 2

    begin
      print "Your choice (#{options.join(', ')}): "
      choice = gets.chomp
      puts
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
      raise EndSession.new
    end
  end

  def dealer_turn
    player = players[:dealer]
    cards = player.cards
    points = Card.points(cards)
    player.add_card(deck.get) if points < 17 && cards.length < 3
  end

  def check_cards_count
    cards_enough = players.values.all? { |player| player.cards.length >= 3 }
    raise EndSession.new if cards_enough
  end

  def show_result
    user = Card.points(players[:user].cards)
    dealer = Card.points(players[:dealer].cards)

    draw = (user > 21 && dealer > 21) || (user == dealer)
    user_win = user > dealer && user < 21

    if draw
      puts "Draw!"
      players.values.each { |player| player.add_money(pool / 2) }
    elsif user_win
      puts "You win!"
      players[:user].add_money(pool)
    else
      puts "You lose!"
      players[:dealer].add_money(pool)
    end
    self.pool = 0
  end
end

def ask_new_session
  print 'Start new session? (n - no): '
  choice = gets.chomp
  puts
  raise EndGame.new if choice.start_with?('n')
end

class EndSession < StandardError; end
class EndGame < StandardError; end
