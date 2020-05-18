module Game
  # Init game conditions
  module Initializer
    START_MONEY = 100

    def init_players
      @players = %i[user dealer].map do |name|
        player = Player.new(name, START_MONEY, Deck.new)
        self.class.send(:define_method, name) { player }
        player
      end
    end

    def init_session
      init_deck
      init_pool
    end

    protected

    def init_deck
      self.deck = Deck.new(Card.all)
      players.each do |player|
        cards = 2.times.map { deck.get }
        player.reset_cards(Deck.new(cards))
      end
    end

    def init_pool
      raise NoMoney.new if players.any? { |player| player.money < 10 }

      self.pool = players.map { |player| player.get_money(10) }.sum
    end
  end
end
