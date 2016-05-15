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
    hand.each do |card|
      total += card.value
    end

    # adjust for Aces
    if total >= 21
      hand.select(&:ace?).count.times do
        total -= 10
      end
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
      name = gets.chomp
      break unless name.empty?
      puts "Your name cannot be blank."
    end
    self.name = name
  end
end

class Dealer < Participant
  NAMES = %w(C3PO R2D2 BB-8)
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
  attr_accessor :cards
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
  SUITS = %w(H D C S)
  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
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
  attr_accessor :player, :dealer, :deck

  def initialize
    puts "Welcome to Twenty-One!"
    puts "The first player to win #{NUM_TO_WIN} hands wins."
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    loop do
      #play NUM_TO_WIN rounds
      loop do
        system 'clear'
        deal_initial
        show_initial_hands

        player_turn
        dealer_turn if !player.bust?

        bust_message
        show_hand_winner
        increment_score
        show_score
        break if player.wins == NUM_TO_WIN || dealer.wins == NUM_TO_WIN
        play_another_hand? ? reset : break
      end
      
      play_another_game? ? reset_game : break
    end

    puts "Thanks for playing Twenty-One! Goodbye."
  end

  private

  def play_another_hand?
    answer = nil
    loop do
      puts "Would you like to play another hand (y/n)?"
      answer = gets.chomp
      break if %w(y n).include? answer
      puts "Please enter 'y' or 'n'"
    end
    answer == 'y'
  end

  def play_another_game?
    answer = nil
    loop do
      puts "Would you like to play another #{NUM_TO_WIN}-hand game?"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Please enter 'y' or 'n'"
    end
    answer == 'y'
  end

  def reset
    self.deck = Deck.new
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
        answer = gets.chomp.downcase
        break if ['h', 's'].include? answer
        puts "Please enter 'h' to hit and 's' to stay."
      end

      if answer == 's'
        puts "#{player.name} chose stay..."
        break
      elsif player.bust?
        break
      elsif answer == 'h'
        player.receive_card(deck.deal_single)
        puts "#{player.name} chose hit..."
        player.show_hand
        break if player.bust?
      end
    end
  end

  def dealer_turn
    puts ""
    puts "#{dealer.name}'s turn:"
    loop do
      if dealer.total < 17
        puts "#{dealer.name} chose hit..."
        dealer.receive_card(deck.deal_single)
        dealer.show_hand if !dealer.bust?
      elsif dealer.bust?
        dealer.show_hand
        break
      elsif dealer.total >= 17 && !dealer.bust? 
        puts "#{dealer.name} chose stay..."
        dealer.show_hand
        break
      end
    end
  end

  def bust_message
    if player.bust?
      puts "You busted! #{dealer.name} wins!"
    elsif dealer.bust?
      puts "#{dealer.name} busts! You win!"
    end
  end

  def show_hand_winner
    if !player.bust? && player.total > dealer.total
      puts "You won!"
    elsif !dealer.bust? && dealer.total > player.total
      puts "The dealer won this round."
    elsif dealer.total == player.total
      puts "It's a tie!"
    end
  end

  def show_game_winner

  end

  def increment_score
    if !player.bust? && player.total > dealer.total
      player.wins += 1
    elsif !dealer.bust? && dealer.total > player.total
      dealer.wins += 1
    elsif player.bust?
      dealer.wins += 1
    elsif dealer.bust?
      player.wins += 1
    end
  end

  def show_score
    puts "Score: #{player.name}: #{player.wins}  #{dealer.name}: #{dealer.wins}"
  end

end

game = TwentyOne.new
game.start