module Game
  # Rules specific to blackjack
  module Rules
    def self.draw?(user, dealer)
      (user > 21 && dealer > 21) || (user == dealer)
    end

    def self.user_win?(user, dealer)
      (user > dealer && user <= 21 && dealer <= 21) || dealer > 21
    end

    def self.game_result(user, dealer)
      user = user.cards.points
      dealer = dealer.cards.points
      return :draw if draw?(user, dealer)
      return :user if user_win?(user, dealer)

      :dealer
    end
  end
end
