# Play card
class Card
  extend CardConstants

  attr_reader_writer :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def points
    self.class.values_points[value]
  end

  def to_s
    eigen = self.class
    suit  = eigen.suits_str[self.suit]
    value = eigen.values_str[self.value]
    "#{value}#{suit}"
  end
end
