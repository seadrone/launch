require 'pry'
class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def joinor(array, delimiter=', ', word='or')
    array[-1] = "#{word} #{array.last}" if array.size > 1
    array.join(delimiter)
  end
  
  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if identical_markers?(squares, 3, nil)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end
  
  def find_at_risk_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if identical_markers?(squares, 2, marker)
        return line.find { |i| @squares[i].marker == Square::INITIAL_MARKER }
      end
    end
    nil
  end
  
  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  
  private
  # def three_identical_markers?(squares)
  #   markers = squares.select(&:marked?).collect(&:marker)
  #   return false if markers.size != 3
  #   markers.min == markers.max
  # end
  
  def identical_markers?(squares, num_markers, marker)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != num_markers
    markers.min == markers.max
  end

end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker
  attr_accessor :score
  
  def initialize(marker)
    @marker = marker
    @score = 0
  end
  
  def round_winner?
    self.score == TTTGame::POINTS_NEEDED_TO_WIN
  end
end




class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  POINTS_NEEDED_TO_WIN = 3

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    # @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    choose_first_player

    loop do
      
      loop do
        display_board
  
        loop do
          current_player_moves
          break if board.someone_won? || board.full?
          clear_screen_and_display_board if human_turn?
        end
  
        display_result_and_keep_score
        display_score
        break if someone_won_the_round?
        break unless play_another_round?
        reset
        display_play_again_message
      end
      
      display_round_winner
      break unless play_another_game?
      reset_all
    end
        
    display_goodbye_message
    
  end

  private
  def choose_first_player
    answer = nil
    loop do
      puts "Would you like to go first?"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, your answer must be y or n."
    end
    answer == 'y' ? @current_marker = HUMAN_MARKER : @current_marker = COMPUTER_MARKER
  end
  
  def display_round_winner
    if human.score == POINTS_NEEDED_TO_WIN
      puts "Congratulations, you won the game!"
    elsif computer.score == POINTS_NEEDED_TO_WIN
      puts "The computer wins this time!"
    end
  end

  def someone_won_the_round?
    if human.round_winner? || computer.round_winner? 
      true
    else
      nil
    end
  end

  def play_another_game?
    answer = nil
    loop do
      puts "Would you like to play another #{POINTS_NEEDED_TO_WIN}-round game? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'    
  end

  def display_score
    puts "Score: You: #{human.score}  Computer: #{computer.score}"
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "You're #{human.marker}'s. Computer is #{computer.marker}'s."
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square: (#{board.joinor(board.unmarked_keys, ', ')})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.find_at_risk_square(computer.marker)
      board[board.find_at_risk_square(computer.marker)] = computer.marker
    elsif board.find_at_risk_square(human.marker)
      board[board.find_at_risk_square(human.marker)] = computer.marker
    elsif board.unmarked_keys.include?(5)
      board[5] = computer.marker
    else # just pick a random empty square
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def display_result_and_keep_score
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      human.score += 1
      puts "You won!"
    when computer.marker
      computer.score += 1
      puts "Computer won!"
    else
      puts "It's a tie!"
    end
  end

  def play_another_round?
    answer = nil
    loop do
      puts "Would you like to play another round? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def reset_all
    reset
    human.score = 0
    computer.score = 0
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
