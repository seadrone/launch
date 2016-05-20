require 'pry'
class Participant
  attr_accessor :name, :hand, :wins
  def initialize
    set_name
    @hand = []
    @wins = 0
  end

  def total
    total = 0
    num_aces = hand.select(&:ace?).count
    hand.each do |card|
      total += card.value
    end

    while total > 21 && num_aces > 0
      total -= 10
      num_aces -= 1
    end
    total
  end

  def bust?
    total > 21
  end

  def receive_card(new_card)
    hand << new_card
  end

  def show_hand
    puts ""
    puts "#{name}'s hand"
    hand.each do |card|
      puts " #{card}"
    end
    puts "Total: #{total}"
    puts ""
  end
end

class Player < Participant
  def set_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp.strip
      break unless name.empty?
      puts "Your name cannot be blank."
    end
    self.name = name
  end
end

class Dealer < Participant
  NAMES = %w(C3PO R2D2 BB-8).freeze
  def set_name
    self.name = NAMES.sample
  end

  def show_initial_hand
    puts "#{name}'s hand"
    puts " #{hand.first}"
    puts " ??"
    puts ""
  end
end

class Deck
  attr_reader :cards
  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    mix!
  end

  def mix!
    cards.shuffle!
  end

  def deal_single
    cards.pop
  end
end

class Card
  SUITS = %w(H D C S).freeze
  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace).freeze

  attr_reader :rank
  
  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def suit
    case @suit
    when 'H'
      'Hearts'
    when 'D'
      'Diamonds'
    when 'C'
      'Clubs'
    when 'S'
      'Spades'
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    case @rank
    when 'Jack' then 10
    when 'Queen' then 10
    when 'King' then 10
    when 'Ace' then 11
    else 
      rank.to_i
    end
  end
  
  def ace?
    rank == 'Ace'
  end
end

class TwentyOne
  NUM_TO_WIN = 3
  attr_reader :player, :dealer, :deck
  def initialize
    puts "Welcome to Twenty-One!"
    puts "The first player to win #{NUM_TO_WIN} hands wins."
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    loop do
      loop do
        system 'clear'
        play_round
        break if player.wins == NUM_TO_WIN || dealer.wins == NUM_TO_WIN
        play_again?('hand') ? reset : break
      end
      
      play_again?('round') ? reset_game : break
    end

    puts "Thanks for playing Twenty-One! Goodbye."
  end

  private

  def play_again?(hand_or_game)
    answer = nil
    message = ''
    message = hand_or_game == 'hand' ? 'hand' : "#{NUM_TO_WIN}-hand game"
    loop do
      puts "Would you like to play another " + message + " (y/n)?"
      answer = gets.chomp.downcase.strip
      break if %w(y n).include? answer
      puts "Please enter 'y' or 'n'"
    end
    answer == 'y'   
  end

  def reset
    deck = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def reset_game
    reset
    player.wins = 0
    dealer.wins = 0
  end

  def deal_initial
    2.times do
      player.hand << deck.deal_single
      dealer.hand << deck.deal_single
    end
  end

  def show_initial_hands
    player.show_hand
    dealer.show_initial_hand
  end

  def player_turn
    puts "#{player.name}'s turn:"
    loop do
      puts "Would you like to hit or stay? (h/s)"
      answer = nil
      loop do
        answer = gets.chomp.downcase.strip
        break if ['h', 's'].include? answer
        puts "Please enter 'h' to hit and 's' to stay."
      end
      process_player_response(answer)
      break if player.bust? || answer == 's'
    end
  end

  def process_player_response(answer)
    if answer == 's'
      puts "#{player.name} chose stay..."
    elsif answer == 'h'
      player.receive_card(deck.deal_single)
      puts "#{player.name} chose hit..."
      player.show_hand
    end
  end

  def dealer_turn
    puts ""
    puts "#{dealer.name}'s turn:"
    loop do
      # process_dealer_turn
      puts "dealer loop"
      #break unless process_dealer_turn
      break if process_dealer_turn
    end
  end
  
  def process_dealer_turn
    if dealer.total < 17
      puts "#{dealer.name} chose hit..."
      dealer.receive_card(deck.deal_single)
    else 
      puts "#{dealer.name} chose stay..."
    end
    
    dealer.show_hand
    dealer_bust_or_keep_going?
  end
  
  def dealer_bust_or_keep_going?
    dealer.bust? || dealer.total >= 17
  end
  
  def calculate_winner
    dealer_total = dealer.total
    player_total = player.total
    if !player.bust? && player_total > dealer_total
      player
    elsif !dealer.bust? && dealer_total > player_total
      dealer
    elsif dealer_total == player_total
      nil
    end
  end
  
  def show_hand_winner_and_increment_score
    if player.bust? || dealer.bust?
      process_busts
    elsif calculate_winner
      process_wins
    else
      puts "It's a tie!"
    end
  end

  def process_wins
    if calculate_winner == player
      player.wins += 1
      puts "You win!"
    else
      dealer.wins += 1
      puts "#{dealer.name} wins!"
    end
  end

  def process_busts
    if player.bust?
      dealer.wins += 1
      puts "You busted! #{dealer.name} wins!"
    elsif dealer.bust?
      player.wins += 1
      puts "#{dealer.name} busts! You win!"
    end
  end

  def show_score
    puts "Score: #{player.name}: #{player.wins}  #{dealer.name}: #{dealer.wins}"
  end

  def play_round
    system 'clear'
    deal_initial
    show_initial_hands

    player_turn
    dealer_turn unless player.bust?

    show_hand_winner_and_increment_score
    show_score
  end

end

game = TwentyOne.new
game.start