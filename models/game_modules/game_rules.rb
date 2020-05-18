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

    def split_pool
      case game_result
      when :draw
        players.each { |player| player.add_money(pool / 2) }
      when :user
        user.add_money(pool)
      when :dealer
        dealer.add_money(pool)
      end
      self.pool = 0
    end
  end
end
