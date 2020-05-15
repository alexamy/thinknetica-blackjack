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
    self.deck = Deck.new(CardSymbols.all)
    deck.shuffle!
  end

  # :reek:DuplicateMethodCall
  def init_hands
    self.players = {
      user: Hand.new(deck.get!(2).each(&:show)),
      dealer: Hand.new(deck.get!(2))
    }
  end

  def add_bets
    bank.place_bet(rules.bet)
  end
end
