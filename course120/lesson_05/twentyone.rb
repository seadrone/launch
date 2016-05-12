class Particpant
  attr_accessor :name
  def initialize
    set_name
  end
end

class Player < Particpant
  def set_name
  end
end

class Dealer < Participant
  def set_name
  end
end

class Participant
end

class Deck
  def initialize
  end
  
  def deal
  end
end

class Card
end

class TwentyOne
  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end
end

game = TwentyOne.new
game.start