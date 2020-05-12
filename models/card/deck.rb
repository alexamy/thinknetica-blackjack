# Deck (or hand) of cards
# :reek:MissingSafeMethod { exclude: [ get! ] }
class Deck
  attr_reader_writer :cards

  delegate :shuffle!, :pop, :push, :[], to: :cards

  def initialize(cards)
    @cards = cards
  end

  def get!(count)
    raise 'Count must be positive!' unless count.positive?

    count.times.map { pop }
  end

  def to_s
    cards.map(&:to_s).join
  end
end

Hand = Deck
