module Game
  # Rules specific to blackjack
  module Rules
    def self.draw?(user, dealer)
      (user > 21 && dealer > 21) || (user == dealer)
    end

    def self.user_win?(user, dealer)
      (user > dealer && user <= 21 && dealer <= 21) || dealer > 21
    end

    def game_result
      user = self.user.cards.points
      dealer = self.dealer.cards.points

      return :draw if Rules.draw?(user, dealer)
      return :user if Rules.user_win?(user, dealer)

      :dealer
    end

    # :reek:TooManyStatements
    def split_pool
      result = game_result
      prize = pool / 2
      self.pool = 0

      players.each { |player| player.add_money(prize) }
      user.add_money(prize) if result == :user
      dealer.add_money(prize) if result == :dealer
    end
  end
end
