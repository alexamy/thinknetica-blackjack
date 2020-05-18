# rubocop:disable all
# :reek:all
# Main entry
class Game
  attr_reader_writer :deck, :players, :pool, :flags, :show_dealer

  START_MONEY = 100

  def initialize
    init_players
  end

  def run
    session_loop
    ask_new_session
  rescue NewGame
    retry
  rescue NoMoney
    show_end_congrat
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

  def init_players
    @players = [:user, :dealer].map do |name|
      player = Player.new(name, START_MONEY)
      self.class.send(:define_method, name) { player }
      player
    end
  end

  def init_session
    self.deck = Deck.new
    players.each(&:throw_cards)
    2.times { players.each { |player| player.add_card(deck.get) } }

    raise NoMoney.new if players.all? { |player| player.money < 10 }
    self.pool = players.map { |player| player.get_money(10) }.sum
  end

  def show_ui(show_dealer = false)
    user = show_player(self.user)
    dealer = show_player(self.dealer, show_dealer)

    puts user, "\n"
    puts dealer, "\n"
    puts "Bank #{pool}$", "\n"
  end

  def show_player(player, visible = true)
    cards = player.cards
    cards_str = cards.map { |card| visible ? card.to_s.ljust(3, ' ') : 'XXX' }
    cards_str = cards_str.join(' ').ljust(12, ' ')

    points = "Σ #{Card.points(cards)}".ljust(4, ' ')
    points = points.gsub(/./, ' ') unless visible

    name = player.name.to_s.rjust(7, ' ')
    money = "#{player.money}$".ljust(4, ' ')

    result = [cards_str, points, name, money]
    result.join(' ')
  end

  def ask_choice
    options = %i[end pass add]
    options.delete(:add) if user.cards.length > 2

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
    case choice
    when :add
      user.add_card(deck.get)
    when :end
      raise EndSession.new
    end
  end

  def dealer_turn
    cards = dealer.cards
    points = Card.points(cards)
    dealer.add_card(deck.get) if points < 17 && cards.length < 3
  end

  def check_cards_count
    cards_enough = players.all? { |player| player.cards.length >= 3 }
    raise EndSession.new if cards_enough
  end

  def show_result
    user = Card.points(self.user.cards)
    dealer = Card.points(self.dealer.cards)

    draw = (user > 21 && dealer > 21) || (user == dealer)
    user_win = (user > dealer && user < 21 && dealer < 21) || dealer > 21

    if draw
      puts "Draw!"
      players.each { |player| player.add_money(pool / 2) }
    elsif user_win
      puts "You win!"
      self.user.add_money(pool)
    else
      puts "You lose!"
      self.dealer.add_money(pool)
    end
    self.pool = 0
  end

  def show_end_congrat
    user = self.user.money
    dealer = self.dealer.money
    puts user > dealer ? "You win!" : "You lose!"
  end

  def ask_new_session
    print 'Start new session? (n - no): '
    choice = gets.chomp
    puts
    raise NewGame.new unless choice.start_with?('n')
  end
end

class EndSession < StandardError; end
class NewGame < StandardError; end
class NoMoney < StandardError; end
