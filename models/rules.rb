# Blackjack rules
class Rules
  attr_reader_writer :start_money, :bet

  def initialize(start_money = 100, bet = 10)
    @start_money = start_money
    @bet = bet
  end

  # rubocop:disable Metrics/MethodLength
  def card_prices
    {
      TWO: 2,
      THREE: 3,
      FOUR: 4,
      FIVE: 5,
      SIX: 6,
      SEVEN: 7,
      EIGHT: 8,
      NINE: 9,
      TEN: 10,
      JACK: 10,
      QUEEN: 10,
      KING: 10
    }
  end
  # rubocop:enable Metrics/MethodLength

  def hand_value(cards)
    values = cards.map do |card|
      CardHelper::Value.constants.find do |k|
        CardHelper::Value.const_get(k) == card.value
      end
    end

    puts values

    aces, others = values.partition { |value| value == :ACE }
  end
end
