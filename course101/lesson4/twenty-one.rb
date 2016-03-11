def prompt(msg)
  puts "=> #{msg}"
end

def new_deck
  ranks = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
  suits = ['Hearts', 'Diamonds', 'Spades', 'Clubs']
  deck  = []
  ranks.each do |rank|
    suits.each do |suit|
      card = [rank, suit]
      deck << card
    end
  end
  deck.shuffle!
end

def deal_card!(deck)
  card = deck.shift
end

def read_card(card)
  "#{card[0]} of #{card[1]}"
end

def print_hand(hand, who)
  printed_hand = []
  hand.each { |card| printed_hand << read_card(card) }
  if hand.size == 2 && who == 'player'
    printed_hand.join(' and ')
  elsif hand.size > 2 && who == 'player'
    last_card = printed_hand.pop
    printed_hand.join(', ') << ' and ' << last_card
  elsif who == 'dealer'
    last_card = printed_hand.pop
    printed_hand.join(', ') << ' and ' << "hidden card"
  end
end

def look_up_values(card)
  rank = card[0]
  case rank
  when '2'
    2
  when '3'
    3
  when '4'
    4
  when '5'
    5
  when '6'
    6
  when '7'
    7
  when '8'
    8
  when '9'
    9
  when '10'
    10
  when 'Jack'
    10
  when 'Queen'
    10
  when 'King'
    10
  when 'Ace'
    1
  end
end

def calculate_score(hand)
  score = 0
  hand.each do |card| 
    score += look_up_values(card)
  end
  score += 10 if hand.count('Ace') > 1
  score
end

def bust?(score)
  score > 21
end

def hit!(deck, hand)
  hand.unshift(deal_card!(deck))
end

def who_won?(player_score, dealer_score)
  if player_score > dealer_score && !bust?(player_score)
    "You won"
  elsif dealer_score > player_score && !bust?(dealer_score)
    "Dealer wins"
  else 
    "Push"
  end
end


dealer_hand = []
player_hand =[]

dealer_score = 0
player_score = 0

prompt("Welcome to Twenty-one!")

deck = new_deck

2.times { dealer_hand << deal_card!(deck) }
2.times { player_hand << deal_card!(deck) }

dealer_score = calculate_score(dealer_hand)
player_score = calculate_score(player_hand)
prompt("Dealer hand: #{print_hand(dealer_hand, 'dealer')}.")
prompt("Your hand: #{print_hand(player_hand, 'player')}. Your score: #{player_score}")

answer = nil
loop do
  prompt("Hit or stay (h or s)?")
  answer = gets.chomp
  if answer == 'h'
    hit!(deck, player_hand) if answer == 'h'
    player_score = calculate_score(player_hand)
    prompt("Your hand: #{print_hand(player_hand, 'player')}. Your score: #{player_score}")
  elsif answer != 'h' && answer != 's'
    prompt("That's not a valid choice. Please choose 'h' to hit or 's' to stay.")
  end
  break if answer == 's' || bust?(player_score)
end

if bust?(player_score)
  prompt("You bust! The dealer wins.")
end

loop do
  if dealer_score >= 17 || bust?(dealer_score)
    break
  else
    hit!(deck, dealer_hand)
    dealer_score = calculate_score(dealer_hand)
  end
end

if bust?(dealer_score)
  prompt("Dealer busts! You win.")
end

prompt(who_won?(player_score, dealer_score)) unless bust?(dealer_score) || bust?(player_score)

prompt("The dealer had: #{print_hand(dealer_hand, 'player')} (#{dealer_score})")
prompt("You had: #{print_hand(player_hand, 'player')} (#{player_score})")
prompt("Thanks for playing Twenty-one!")