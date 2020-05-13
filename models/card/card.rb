# Simple card
class Card
  attr_reader_writer :value, :suit, :hidden

  def initialize(value, suit, hidden = true)
    @value = value
    @suit = suit
    @hidden = hidden
  end

  def show
    self.hidden = false
  end

  def hide
    self.hidden = true
  end

  def toggle
    self.hidden = !hidden
  end

  def to_s
    code = hidden ? CardHelper::HIDDEN : CardHelper.code(value, suit)
    "#{code.chr('UTF-8')} "
  end
end
