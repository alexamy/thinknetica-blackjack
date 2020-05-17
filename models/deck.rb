# Standard 52-card deck
class Deck
  attr_reader_writer :cards

  delegate :pop, :push, to: :cards
  alias get pop
  alias add push

  def initialize
    all = Card.suits.product(Card.values)
    @cards = all.map { |opts| Card.new(*opts) }.shuffle
  end
end
