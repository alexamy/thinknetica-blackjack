# Bank and money pool for bets
class Bank
  attr_reader :accounts, :pool

  def initialize
    @accounts = []
    @pool = 0
  end

  def add_account(name, amount)
    raise "Already created account: #{name}" if accounts[name]

    accounts[name] = amount
  end

  def to_pool(name, amount)
    money_after = accounts[name] - amount
    raise "#{name} can't give #{amount}" if money_after.negative?

    accounts[name] = money_after
    self.pool += amount
  end

  def from_pool(name, amount)
    money_after = pool - amount
    raise "Pool don't have #{amount}" if money_after.negative?

    accounts[name] += amount
    self.pool = money_after
  end

  protected

  attr_writer :accounts, :pool
end
