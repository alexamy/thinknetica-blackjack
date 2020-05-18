module Game
  # Init game conditions
  module Initializer
    START_MONEY = 100

    def init_players
      user_name = get_input('your name').to_sym
      @players = [user_name, :dealer].map do |name|
        Player.new(name, START_MONEY, Deck.new)
      end

      init_player_methods
    end

    def init_session
      init_deck
      init_pool
    end

    protected

    def init_player_methods
      %i[user dealer].zip(players).each do |key, player|
        self.class.send(:define_method, key) { player }
      end
    end

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
