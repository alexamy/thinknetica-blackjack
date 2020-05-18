# Standard 52-card deck
class Deck
  attr_reader_writer :cards

  delegate :pop, :push, :map, :length, to: :cards

  alias get pop
  alias add push

  def initialize(cards = [])
    @cards = cards.shuffle
  end

  def points
    sum = cards.sum(&:points)
    aces = cards.select { |card| card.value == :ace }

    sum += 10 if aces.any? && sum + 10 <= 21
    sum
  end
end
