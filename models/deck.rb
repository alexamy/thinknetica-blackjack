# Standard 52-card deck
class Deck
  attr_reader_writer :cards

  delegate :pop, :push, to: :cards
  alias get pop
  alias add push

  def initialize(cards)
    @cards = cards.shuffle
  end
end
