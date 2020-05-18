# Player and dealer class
# :reek:Attribute
class Player
  include PlayerPrint

  attr_accessor :visible
  attr_reader_writer :name, :money, :cards

  alias deck cards

  def initialize(name, money, cards, visible = true)
    @name = name
    @money = money
    @cards = cards
    @visible = visible
  end

  def add_money(amount)
    self.money += amount
  end

  def get_money(amount)
    self.money -= amount
    amount
  end

  def reset_cards(cards)
    self.cards = cards
  end
end
