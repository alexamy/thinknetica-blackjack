# Card enums with unicode characters
# :reek:TooManyConstants
module CardSymbols
  PREFIX = 0x1F000
  HIDDEN = 0x1F0A0

  # rubocop:disable Metrics/MethodLength
  def self.values
    {
      ace: 1,
      two: 2,
      three: 3,
      four: 4,
      five: 5,
      six: 6,
      seven: 7,
      eight: 8,
      nine: 9,
      ten: 0xA,
      jack: 0xB,
      queen: 0xD,
      king: 0xE
    }
  end
  # rubocop:enable Metrics/MethodLength

  def self.suits
    {
      spades: 0xA,
      hearts: 0xB,
      diamonds: 0xC,
      clubs: 0xD
    }
  end

  def self.all
    pairs = suits.keys.product(values.keys)
    pairs.map { |suit, value| Card.new(value, suit) }
  end

  def self.code(value, suit)
    PREFIX + suits[suit] * 0x10 + values[value]
  end
end
