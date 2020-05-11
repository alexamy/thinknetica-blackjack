# main class
class Game
  include GameInitializer

  def initialize
  end

  def run
    ask_name
    init_bank_accounts
    loop do
      check_game_end
      init_session
      game_loop
    end
  end

  def init_session
    init_deck
    add_cards
    add_bets
  end

  def ask_name
    # ask and save user name
  end

  def check_game_end
    # end game, if one of the players have 0 money
  end

  def add_cards
    # give each player 2 cards
  end

  def add_bets
    # add standard bet to bank pool
  end

  def game_loop
    loop do
      show_ui
      player_turn
      dealer_turn
      break if end_session?
    end
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
