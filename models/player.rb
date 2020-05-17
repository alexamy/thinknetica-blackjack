# Player and dealer class
class Player
  attr_reader_writer :name

  def initialize(name, money)
    @name = name
    @money = money
  end
end
