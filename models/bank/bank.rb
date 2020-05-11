# Bank and money pool for bets
class Bank
  attr_reader_writer :player, :dealer, :pool

  def initialize(start_money)
    @player = Account.new(:player, start_money)
    @dealer = Account.new(:dealer, start_money)
    @pool = Account.new(:pool, 0)
  end

  def place_bet(amount)
    pool.from(player, amount)
    pool.from(dealer, amount)
  end

  def player_won
    player.from(pool)
  end

  def dealer_won
    dealer.from(pool)
  end
end
