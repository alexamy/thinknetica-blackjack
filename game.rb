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
    session_loop
    ask_new_session
  rescue NewGame
    retry
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

  def show_ui(show_dealer = false)
    player = show_player(:user, players[:user])
    dealer = show_player(:dealer, players[:dealer], show_dealer)

    puts player, "\n"
    puts dealer, "\n"
    puts "Bank #{pool}$", "\n"
  end

  def show_player(name, player, visible = true)
    cards = player.cards
    cards_str = cards.map { |card| visible ? card.to_s.ljust(3, ' ') : 'XXX' }
    cards_str = cards_str.join(' ').ljust(12, ' ')

    points = "Σ #{Card.points(cards)}".ljust(2, ' ')
    points = points.gsub(/./, ' ') unless visible

    name = name.to_s.rjust(7, ' ')
    money = "#{player.money}$".ljust(3, ' ')

    result = [cards_str, points, name, money]
    result.join(' ')
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
    user_win = (user > dealer && user < 21 && dealer < 21) || dealer > 21

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
  raise NewGame.new unless choice.start_with?('n')
end

class EndSession < StandardError; end
class NewGame < StandardError; end
