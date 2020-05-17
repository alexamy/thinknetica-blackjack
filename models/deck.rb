# Standard 52-card deck
class Deck
  attr_reader_writer :cards

  def initialize
    all = Card.suits.product(Card.values)
    @cards = all.map { |opts| Card.new(*opts) }
  end
end
