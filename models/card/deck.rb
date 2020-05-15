# Deck (or hand) of cards
# :reek:MissingSafeMethod { exclude: [ get! ] }
class Deck
  attr_reader_writer :cards

  delegate :shuffle!, :pop, :push, :[], to: :cards

  alias get! pop
  alias add! push

  def initialize(cards)
    @cards = cards
  end

  def top_card
    cards.last
  end

  def to_s
    cards.map(&:to_s).join
  end
end

Hand = Deck
