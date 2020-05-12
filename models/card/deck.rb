# Deck (or hand) of cards
class Deck
  attr_reader_writer :cards

  delegate :shuffle!, :pop, :push, :[], to: :cards

  def initialize(cards)
    @cards = cards
  end

  def to_s
    cards.map(&:to_s).join
  end
end
