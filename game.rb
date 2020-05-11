# main class
class Game
  include Rules

  attr_reader_writer :bank

  def initialize
    @bank = Bank.new(START_MONEY)
  end

  def run
    ask_name
    game_loop
    show_game_results
  end

  def init_session
    init_deck
    add_cards
    add_bets
  end

  def ask_name
    # ask and save user name
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
    # initialize standard 52 cards deck
  end

  def add_cards
    # give each player 2 cards
  end

  def add_bets
    # add standard bet to bank pool
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
