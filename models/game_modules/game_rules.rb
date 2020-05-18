module Game
  # Rules specific to blackjack
  module Rules
    def self.draw?(user, dealer)
      (user > 21 && dealer > 21) || (user == dealer)
    end

    def self.user_win?(user, dealer)
      (user > dealer && user <= 21 && dealer <= 21) || dealer > 21
    end
  end
end
