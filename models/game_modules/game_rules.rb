module Game
  # Rules specific to blackjack
  module Rules
    def self.draw?(user, dealer)
      (user > 21 && dealer > 21) || (user == dealer)
    end

    def self.user_win?(user, dealer)
      (user > dealer && user <= 21 && dealer <= 21) || dealer > 21
    end

    def self.points(cards)
      sum = cards.sum(&:points)
      aces = cards.select { |card| card.value == :ace }

      sum += 10 if aces.any? && sum + 10 <= 21
      sum
    end
  end
end
