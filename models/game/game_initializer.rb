# Initialize game session
module GameInitializer
  def init_session
    init_deck
    init_hands
    add_bets
  end

  def init_bank
    self.bank = Bank.new(rules.start_money, name)
  end

  def init_deck
    self.deck = Deck.new(CardHelper.all)
    deck.shuffle!
  end

  # :reek:DuplicateMethodCall
  def init_hands
    self.player = Hand.new(deck.get!(2).each(&:show))
    self.dealer = Hand.new(deck.get!(2))
  end

  def add_bets
    bank.place_bet(rules.bet)
  end
end
