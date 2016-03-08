require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [3, 5, 7], [1, 5, 9]]
NUM_TO_WIN = 2
STARTING_PLAYER = "choose"

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, punct, word)
  return arr.join() if arr.size < 2
  return arr.join(' or ') if arr.size == 2 
  last_val = arr.pop
  arr.join("#{punct} ")<< "#{punct} #{word} #{last_val}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are #{PLAYER_MARKER}'s and the computer is #{COMPUTER_MARKER}'s."
  puts "The first player to win #{NUM_TO_WIN} games wins."
  puts ""
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt("Choose a square (#{joinor(empty_squares(brd), ',', 'or')})")
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry that's not a valid choice.")
  end
  brd[square] = PLAYER_MARKER
end

def detect_third_square(brd, marker)
 WINNING_LINES.each do |line|
    if brd.values_at(*line).count(marker) == 2 && brd.values_at(*line).count(' ') == 1
      action_square = line[brd.values_at(*line).find_index(' ').to_i]
      return action_square
    end
  end
  nil
end

def computer_defend!(brd, square)
 brd[square] = COMPUTER_MARKER
end

def computer_offense!(brd, square)
  brd[square] = COMPUTER_MARKER
end

def check_square_five?(brd)
  brd[5] == ' '
end

def computer_places_piece!(brd)
  if check_square_five?(brd)
    brd[5] = COMPUTER_MARKER 
  else
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 3
      return 'You'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def display_game_winner(brd)
  prompt("#{detect_winner(brd)} won!") if someone_won?(brd)
  prompt("It's a tie!") if (board_full?(brd) && !detect_winner(brd))
end

def computer_turn!(brd)
  offense_square = detect_third_square(brd, COMPUTER_MARKER) # computer offensive logic
  if offense_square 
    computer_offense!(brd, offense_square) 
  else
    defense_square = detect_third_square(brd, PLAYER_MARKER) # computer defense logic
    if defense_square
      computer_defend!(brd, defense_square)
    else
      computer_places_piece!(brd)
    end
  end
end

def place_piece!(brd, player)
  if player == 1 # 1 is the user
    player_places_piece!(brd)
  elsif player == 2 # 2 is the computer
    computer_turn!(brd)
  end
end

def alternate_player(player)
  next_player = 2 if player == 1
  next_player = 1 if player == 2
  return next_player
end

def choose_first_player
  prompt("Would you like to go first (y or n)?")
  user_choice = gets.chomp
  if user_choice == 'y' 
    return 1  
  else 
    return 2
  end
end

def play_again?(winner, user_score, computer_score)
  prompt("Congratulations!") if winner == 'You'
  prompt("Bummer, the computer won.") if winner == 'Computer'
  prompt("The final score is: You: #{user_score} Computer: #{computer_score}")
  prompt("Do you want to play again (y or n)?")
  answer = gets.chomp
  return answer
end

user_score = 0
computer_score = 0

if STARTING_PLAYER == 'choose'
  current_player = choose_first_player 
else
  current_player = STARTING_PLAYER
end

loop do
  board = initialize_board
  loop do
    display_board(board)
    prompt("Your score is: #{user_score}. Computer's score is: #{computer_score}.")
    place_piece!(board, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  user_score += 1 if detect_winner(board) == 'You'
  computer_score += 1 if detect_winner(board) == 'Computer'

  display_game_winner(board)
  sleep(1.5) unless user_score == NUM_TO_WIN || computer_score == NUM_TO_WIN

  if user_score == NUM_TO_WIN
    answer = play_again?('You', user_score, computer_score)
    break unless answer.downcase.start_with?('y')
  elsif computer_score == NUM_TO_WIN
    answer = play_again?('Computer', user_score, computer_score)
    break unless answer.downcase.start_with?('y')
  end

  if STARTING_PLAYER == 'choose'
    current_player = choose_first_player 
  else
    current_player = STARTING_PLAYER
  end

end

prompt("Thanks for playing. Goodbye.")