# Cards string representation
module CardConstants
  def suits
    %i[diamonds clubs hearts spades]
  end

  def values
    %i[ace two three four five six seven eight nine ten jack queen king]
  end

  def suits_str
    strings = %w[♦ ♣ ♥ ♠]
    suits.zip(strings).to_h
  end

  def values_str
    strings = %w[A 2 3 4 5 6 7 8 9 T J Q K]
    values.zip(strings).to_h
  end

  def values_points
    prices = (1..10).to_a.push(10, 10, 10)
    values.zip(prices)[1..-1].to_h
  end

  def points(cards)
    points = values_points
    aces, others = cards.partition { |card| card.value == :ace }

    sum = others.sum { |card| points[card.value] }
    aces.each { sum += sum + 11 < 21 ? 11 : 1 }
    sum
  end
end
