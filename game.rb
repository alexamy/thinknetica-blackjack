# main class
class Game
  include Rules

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

  def init_session
    init_deck
    init_hands
    add_bets
  end

  def ask_name
    puts 'What is your name?'
    name = gets.chomp
    self.name = name unless name.empty?
  end

  def game_loop
    loop do
      return if game_end?

      init_session
      session_loop
    end
  end

  def session_loop
    loop do
      show_ui
      player_turn
      dealer_turn
      return if end_session?
    end
  end

  def game_end?
    # end game, if one of the players have 0 money
  end

  def init_deck
    self.deck = Deck.new(CardHelper.all)
    deck.shuffle!
  end

  # :reek:DuplicateMethodCall
  def init_hands
    self.player = Hand.new(deck.get!(2))
    self.dealer = Hand.new(deck.get!(2))
  end

  def add_bets
    bank.place_bet(BET)
  end

  def show_game_results
    # show winner
  end

  def show_ui
    # render ui
  end

  def player_turn
    # ask player what to do
  end

  def dealer_turn
    # ai decision what to do
  end

  def end_session?
    # should game session end?
  end
end
