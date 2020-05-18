# session must end
class EndSession < StandardError; end

# user ask for a new game
class NewGame < StandardError; end

# end game if no money left
class NoMoney < StandardError; end
