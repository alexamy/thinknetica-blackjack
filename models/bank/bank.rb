# Bank and money pool for bets
class Bank
  attr_reader_writer :user, :dealer, :pool

  def initialize(start_money, user_name)
    @user = BankAccount.new(user_name, start_money)
    @dealer = BankAccount.new(:dealer, start_money)
    @pool = BankAccount.new(:pool, 0)
  end

  def place_bet(amount)
    pool.from(user, amount)
    pool.from(dealer, amount)
  end

  def user_won
    user << pool
  end

  def dealer_won
    dealer << pool
  end
end
