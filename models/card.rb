# Play card
class Card
  extend CardConstants

  attr_reader_writer :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    suit = self.class.suits_str[self.suit]
    value = self.class.values_str[self.value]
    "#{value}#{suit}".ljust(3, ' ')
  end
end
