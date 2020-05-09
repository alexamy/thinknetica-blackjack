# Card enums with unicode print
module Card
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

  def self.name_to_const(name)
    value, suit = name.split(' ')
    value = Value.const_get(value.upcase.to_sym)
    suit = Suit.const_get(suit.upcase.to_sym)
    { value: value, suit: suit }
  end

  def self.code(suit:, value:)
    PREFIX + suit * 0x10 + value
  end

  def self.symbol(char)
    char.chr('UTF-8')
  end

  def self.get(name)
    opts = name_to_const(name)
    code = code(**opts)
    symbol = symbol(code)
    symbol
  end
end
