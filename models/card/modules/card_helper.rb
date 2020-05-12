# Card enums with unicode characters
# :reek:TooManyConstants
module CardHelper
  PREFIX = 0x1F000
  HIDDEN = 0x1F0A0

  # Values
  module Value
    ACE = 1
    TWO = 2
    THREE = 3
    FOUR = 4
    FIVE = 5
    SIX = 6
    SEVEN = 7
    EIGHT = 8
    NINE = 9
    TEN = 0xA
    JACK = 0xB
    QUEEN = 0xD
    KING = 0xE
  end

  # Suits
  module Suit
    SPADES = 0xA
    HEARTS = 0xB
    DIAMONDS = 0xC
    CLUBS = 0xD
  end

  def self.all(hidden = true)
    pairs = Suit.constants.product(Value.constants)
    pairs.map { |suit, value| Card.new(value, suit, hidden) }
  end

  def self.code(value, suit)
    value = Value.const_get(value)
    suit = Suit.const_get(suit)
    PREFIX + suit * 0x10 + value
  end
end
