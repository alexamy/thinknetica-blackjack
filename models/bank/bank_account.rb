# Bank account
class BankAccount
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

  def to(other, amount = self.amount)
    sub(amount)
    other.add(amount)
  end

  def from(other)
    other.to(self)
  end
end