# Bank account
class Account
  attr_reader :name, :amount

  def initialize(name, amount)
    @name = name
    @amount = amount
  end

  def give(amount)
    self.amount += amount
  end

  def get(amount)
    after = self.amount - amount
    raise "#{name} can't give #{amount}" if money_after.negative?

    self.amount = after
  end

  # :reek:FeatureEnvy
  def from(other, amount)
    amount ||= other.amount
    other.get(amount)
    give(amount)
  end

  def to(other, amount)
    amount ||= self.amount
    get(amount)
    other.give(amount)
  end

  protected

  attr_writer :name, :amount
end

# Bank and money pool for bets
class Bank
  attr_reader :player, :dealer, :pool

  def initialize(start_money)
    @player = Account.new(:player, start_money)
    @dealer = Account.new(:dealer, start_money)
    @pool = Account.new(:pool, start_money)
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

  protected

  attr_writer :player, :dealer, :pool
end
