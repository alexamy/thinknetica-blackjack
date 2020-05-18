module Game
  # Init game conditions
  module Initializer
    START_MONEY = 100

    def init_players
      @players = [:user, :dealer].map do |name|
        player = Player.new(name, START_MONEY)
        self.class.send(:define_method, name) { player }
        player
      end
    end

    def init_session
      self.deck = Deck.new
      players.each(&:throw_cards)
      2.times { players.each { |player| player.add_card(deck.get) } }

      raise NoMoney.new if players.all? { |player| player.money < 10 }
      self.pool = players.map { |player| player.get_money(10) }.sum
    end
  end
end