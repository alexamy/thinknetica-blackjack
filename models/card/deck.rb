# Deck (or hand) of cards
# :reek:MissingSafeMethod { exclude: [ get! ] }
class Deck
  attr_reader_writer :cards

  delegate :shuffle!, :pop, :push, :[], to: :cards

  def initialize(cards)
    @cards = cards
  end

  def to_s
    cards.map(&:to_s).join
  end

  def top_card
    cards.last
  end

  alias get! pop
end

Hand = Deck
