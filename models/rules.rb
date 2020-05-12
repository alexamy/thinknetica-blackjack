# Blackjack rules
class Rules
  attr_reader_writer :start_money, :bet

  def initialize(start_money = 100, bet = 10)
    @start_money = start_money
    @bet = bet
  end

  def hand_value(cards)
    # determine hand cards values sum
  end
end
