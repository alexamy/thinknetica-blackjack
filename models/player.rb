# Player and dealer class
class Player
  attr_reader_writer :name, :money, :cards

  def initialize(money, cards = [])
    @money = money
    @cards = cards
  end

  def get_money(amount)
    self.money -= amount
    amount
  end

  def add_card(card)
    cards << card
  end

  def throw_cards
    self.cards = []
  end
end
