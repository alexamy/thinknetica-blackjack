# Bank account
class Account
  attr_reader_writer :name, :amount

  def initialize(name, amount)
    @name = name
    @amount = amount
  end

  def add(amount)
    self.amount += amount
  end

  def sub(amount)
    after = self.amount - amount
    raise "#{name} can't give #{amount}" if after.negative?

    self.amount = after
  end

  # :reek:FeatureEnvy
  def from(other, amount = other.amount)
    other.sub(amount)
    add(amount)
  end

  def to(other, amount = self.amount)
    sub(amount)
    other.add(amount)
  end
end

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
