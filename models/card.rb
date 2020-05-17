# Play card
class Card
  extend CardConstants

  attr_reader_writer :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    suit = self.class.suits_str[suit]
    value = self.class.values_str[value]
    "#{value}#{suit} "
  end
end
