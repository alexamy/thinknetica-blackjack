# Initialize game session
module GameInitializer
  def init_session
    init_deck
    init_hands
    add_bets
  end

  def init_deck
    self.deck = Deck.new(CardHelper.all)
    deck.shuffle!
  end

  # :reek:DuplicateMethodCall
  def init_hands
    self.player = Hand.new(deck.get!(2))
    self.dealer = Hand.new(deck.get!(2))
  end

  def add_bets
    bank.place_bet(BET)
  end
end
