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

def print_hand(hand, show_or_hide)
  printed_hand = []
  hand.each { |card| printed_hand << read_card(card) }
  if hand.size == 2 && show_or_hide == 'show'
    printed_hand.join(' and ')
  elsif hand.size > 2 && show_or_hide == 'show'
    last_card = printed_hand.pop
    printed_hand.join(', ') << ' and ' << last_card
  elsif hand.size == 2 && show_or_hide == 'hide'
    printed_hand[0] << ' and ' << '??'
  elsif hand.size > 2 && show_or_hide == 'hide'
    last_card = printed_hand.pop
    printed_hand.join(', ') << ' and ' << '??'
  end
end

def calculate_score(hand)
  score = 0
  hand.each do |card|
    if card[0] == 'A'
      score += 11
    elsif card[0].to_i == 0
      score += 10
    else
      score += card[0].to_i
    end
  end
  hand.select {|value| value == 'Ace'}.count.times do 
    score -= 10 if score > 21
  end
  
  score
end

def bust?(score)
  score > 21
end

def hit!(deck, hand)
  hand.unshift(deal_card!(deck))
end

def who_won(player_score, dealer_score)
  if player_score > dealer_score 
    "You won"
  elsif dealer_score > player_score
    "Dealer wins"
  else 
    "It's a tie"
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
prompt("Dealer's hand: #{print_hand(dealer_hand, 'hide')}.")
prompt("Your hand: #{print_hand(player_hand, 'show')}. Your total: #{player_score}")

loop do
  prompt("Hit or stay (h or s)?")
  answer = gets.chomp
  if answer == 'h'
    prompt("You chose to hit")
    hit!(deck, player_hand)
    player_score = calculate_score(player_hand)
    prompt("Your hand is now: #{print_hand(player_hand, 'show')}. Your total: #{player_score}")
    break if bust?(player_score)
  elsif answer == 's'
    prompt("You chose to stay at #{player_score}.")
    prompt("================")
    break
  else
    prompt("That's not a valid choice. Please choose 'h' to hit or 's' to stay.")
  end
end

if bust?(player_score)
  prompt("You bust! The dealer wins.")
else
  prompt("The dealer's turn...")
  loop do
    if dealer_score >= 17 || bust?(dealer_score)
      prompt("The dealer stays at #{dealer_score}")
      break
    else
      prompt("The dealer hits")
      hit!(deck, dealer_hand)
      dealer_score = calculate_score(dealer_hand)
      prompt("The dealer's hand is now: #{print_hand(dealer_hand, 'show')}. Dealer's total is #{dealer_score}")
      prompt("================")
      break if bust?(dealer_score)
    end
  end
end

if bust?(dealer_score)
  prompt("Dealer busts! You win.")
else
  prompt("================")
  prompt(who_won(player_score, dealer_score)) unless bust?(dealer_score) || bust?(player_score)
  prompt("The dealer had: #{print_hand(dealer_hand, 'show')}. Dealer's total: #{dealer_score}")
  prompt("You had: #{print_hand(player_hand, 'show')}. Your total: #{player_score}")
  prompt("================")
end

prompt("Thanks for playing Twenty-one!")