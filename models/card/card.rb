# Simple card
class Card
  attr_reader_writer :value, :suit, :hidden

  # :reek:BooleanParameter
  def initialize(value, suit, hidden = false)
    @value = value
    @suit = suit
    @hidden = hidden
  end

  def toggle
    self.hidden = !hidden
  end

  def to_s
    code = hidden ? CardHelper::HIDDEN : CardHelper.code(value, suit)
    code.chr('UTF-8')
  end
end
