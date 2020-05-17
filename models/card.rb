# Play card
class Card
  include CardConstants

  attr_reader_writer :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    suit = suits_str[suit]
    value = values_str[value]
    "#{value}#{suit} "
  end
end
