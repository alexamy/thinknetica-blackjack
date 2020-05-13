# Bank and money pool for bets
class Bank
  attr_reader_writer :player, :dealer, :pool

  def initialize(start_money, player_name)
    @player = BankAccount.new(player_name, start_money)
    @dealer = BankAccount.new(:dealer, start_money)
    @pool = BankAccount.new(:pool, 0)
  end

  def place_bet(amount)
    pool.from(player, amount)
    pool.from(dealer, amount)
  end

  def player_won
    player << pool
  end

  def dealer_won
    dealer << pool
  end
end
