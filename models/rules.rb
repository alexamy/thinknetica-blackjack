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
    CardSymbols.values.except(:ace).merge(prices)
  end

  # :reek:TooManyStatements
  def hand_value(cards)
    values = self.class.card_prices
    aces, others = cards.map(&:value).partition { |value| value == :ace }

    sum = others.sum { |name| values[name] }
    aces.each do
      value = sum + 11 <= 21 ? 11 : 1
      sum += value
    end

    sum
  end
end
