require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [3, 5, 7], [1, 5, 9]]
NUM_TO_WIN = 2

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, punct, word)
  return arr.join() if arr.size < 2
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

def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  # return true if empty_squares(brd).length == 0
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

user_score = 0
computer_score = 0

loop do
  board = initialize_board
  loop do
    display_board(board)
    prompt("Your score is: #{user_score}. Computer's score is: #{computer_score}.")
    player_places_piece!(board)
    break if someone_won?(board) || board_full?(board)
    computer_places_piece!(board)
    display_board(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_board(board)

  user_score += 1 if detect_winner(board) == 'You'
  computer_score += 1 if detect_winner(board) == 'Computer'

  display_game_winner(board)
  sleep(1.2) unless user_score == NUM_TO_WIN || computer_score == NUM_TO_WIN

  if user_score == NUM_TO_WIN
    user_score = 0
    computer_score = 0
    prompt("Congratulations!")
    prompt("Do you want to play again? (y or n)")
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  elsif computer_score == NUM_TO_WIN
    user_score = 0
    computer_score = 0
    prompt("Bummer, the computer wins.")
    prompt("Do you want to play again? (y or n)")
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end

end

prompt("Thanks for playing. Goodbye.")


