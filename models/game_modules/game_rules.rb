module Game
  # Rules specific to blackjack
  module Rules
    def self.draw?(user, dealer)
      (user > 21 && dealer > 21) || (user == dealer)
    end

    def self.user_win?(user, dealer)
      (user > dealer && user <= 21 && dealer <= 21) || dealer > 21
    end

    # :reek:TooManyStatements
    def self.points(cards)
      aces, others = cards.partition { |card| card.value == :ace }
      sum = others.sum(&:points)
      aces.each { sum += sum + 11 < 21 ? 11 : 1 }
      sum
    end
  end
end
