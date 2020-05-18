# print player data
module PlayerPrint
  def to_s
    %i[cards points name money]
      .map { |key| send("show_#{key}") }
      .join(' ')
  end

  protected

  def show_cards
    cards.map { |card| visible ? card.to_s.ljust(3, ' ') : '***' }
         .join(' ')
         .ljust(12, ' ')
  end

  def show_points
    points = "Σ #{cards.points}".ljust(4, ' ')
    points = points.gsub(/./, ' ') unless visible
    points
  end

  def show_name
    name.to_s.rjust(7, ' ')
  end

  def show_money
    "#{money}$".ljust(4, ' ')
  end
end
