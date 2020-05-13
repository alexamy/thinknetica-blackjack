# Blackjack rules
class Rules
  attr_reader_writer :start_money, :bet

  def initialize(start_money = 100, bet = 10)
    @start_money = start_money
    @bet = bet
  end

  def self.card_prices
    prices = {
      jack: 10,
      queen: 10,
      king: 10
    }
    result = CardSymbols.values.merge(prices)
    result.delete(:ace)
    result
  end

  def hand_value(cards)
    aces, others = cards.map(&:value).partition { |value| value == :ace }
  end
end
