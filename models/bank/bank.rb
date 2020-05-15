# Bank and money pool for bets
class Bank
  attr_reader_writer :accounts, :pool

  def initialize(start_money, user_name)
    @pool = BankAccount.new(:pool, 0)
    @accounts = {
      user: BankAccount.new(user_name, start_money),
      dealer: BankAccount.new(:dealer, start_money)
    }
  end

  def place_bet(amount)
    pool.from(accounts[:user], amount)
    pool.from(accounts[:dealer], amount)
  end

  def user_won
    accounts[:user] << pool
  end

  def dealer_won
    accounts[:dealer] << pool
  end

  def draw
    half = pool.amount / 2
    pool.to(accounts[:user], half)
    pool.to(accounts[:dealer], half)
  end
end
