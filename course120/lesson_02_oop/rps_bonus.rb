class Scoreboard
  attr_accessor :board
  attr_reader :p1, :p2

  def initialize(player1, player2)
    @p1 = player1
    @p2 = player2
    @board = {header: ["#{p1.name}".slice(0, 14), "#{p2.name}"]}
  end

  def update_board
    rounds = @board.size - 1
    @board[rounds+1] = [p1.move, p2.move]
  end

  def print_board
    puts ""
    puts "-" * 28
    puts "SCOREBOARD".center(28, ' ')
    puts "-" * 28
    puts "#{board[:header][0]}".center(14, ' ') + '|' + "#{board[:header][1]}".center(14, ' ')
    puts "-" * 14 + '+' + "-" * 14
    i = 1
    loop do
      puts "#{board[i][0]}".center(14, ' ') + '|' + "#{board[i][1]}".center(14, ' ')
      i += 1
      break if i == @board.size
    end
    puts "-" * 28
    puts "#{p1.score}".center(14, ' ') + '|' + "#{p2.score}".center(14, ' ')
    puts ""
  end

end

class Player
  attr_accessor :move, :name, :score, :history
  def initialize
    @history = []
    @score = 0
  end

  def set_move_choice(choice)
    self.move = get_move(choice)
  end

  def get_move(choice)
    case choice
    when 'rock'
      Rock.new
    when 'paper'
      Paper.new
    when 'scissors'
      Scissors.new
    when 'lizard'
      Lizard.new
    when 'spock'
      Spock.new
    end
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  attr_reader :defeats, :loses_to

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def paper?
    @value == 'paper'
  end

  def rock?
    @value == 'rock'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def defeats?(other_move)
    defeats.include?(other_move.to_s)
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @defeats = ['scissors', 'lizard']
    @loses_to = ['paper', 'spock']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @defeats = ['rock', 'spock']
    @loses_to = ['scissors', 'lizard']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @defeats = ['paper', 'lizard']
    @loses_to = ['rock', 'spock']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @defeats = ['paper', 'spock']
    @loses_to = ['scissors', 'rock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @defeats = ['scissors', 'rock']
    @loses_to = ['lizard', 'paper']
  end
end

class Human < Player
  def initialize
    set_name
  end
  def set_name
    n = ''
    system 'clear'
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, that's not a valid choice."
    end
    self.move = set_move_choice(choice)
    self.history << self.move
  end
end

class Computer < Player
  def choose(opponent)
    if opponent.history.length < 2
      # self.move = set_move_choice(Move::VALUES.sample)
      # self.history << self.move
      move = Move::VALUES.sample
    else
      occurrences = {}
      opponent.history.each do |move|
        if occurrences[move.to_s]
          occurrences[move.to_s] += 1
        else 
          occurrences[move.to_s] = 1
        end
      end
      max = occurrences.values.sort {|a,b| b <=> a}.first
      smart_sample = []
      highest_occurring_moves = occurrences.select {|k,v| v >= max}.keys
      highest_occurring_moves.each do |move|
      get_move(move).loses_to.map {|str| smart_sample << str}
      end
      move = smart_sample.sample
    end
    self.move = set_move_choice(move)
    self.history << self.move
  end

  def name
    @name.capitalize
  end
end

class R2D2 < Computer # will not choose a Star Trek character
  def initialize
    @name = 'r2d2'
  end
  def choose(opponent)
    self.move = set_move_choice(['rock', 'paper', 'scissors', 'lizard'].sample)
    self.history << self.move
  end
  def name
    "R2D2"
  end
end

class Hal < Computer # only chooses from moves that can kill humans
  def initialize
    @name = 'hal'
  end
  def choose(opponent)
    self.move = set_move_choice(['rock', 'scissors'].sample)
    self.history << self.move
  end
end

class Chappie < Computer # default bot behavior
  def initialize
    @name = 'chappie'
  end
end

class Sonny < Computer # only chooses moves that start with 's'
  def initialize
    @name = 'sonny'
  end
  def choose(opponent)
    self.move = set_move_choice(['scissors', 'spock'].sample)
    self.history << self.move
  end
end

class Number5 < Computer # only chooses moves that have more than 5 letters
  def initialize
    @name = 'number5'
  end
  def choose(opponent)
    self.move = set_move_choice(['scissors', 'lizard'].sample)
    self.history << self.move
  end
end

class RPSGame
  GAMES_TO_WIN = 10
  attr_accessor :human, :computer, :board

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Hi, #{human.name}! Welcome to " + Move::VALUES.map(&:capitalize).join(', ') + "!"
    puts "The first player to win #{GAMES_TO_WIN} games wins. Good luck."
  end

  def display_goodbye_message
    puts "Thanks for playing #{titlelize(Move::VALUES)}. Goodbye!"
  end

  def display_moves
    system 'clear'
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def calculate_winner
    if human.move.defeats?(computer.move)
      human.name
    elsif computer.move.defeats?(human.move)
      computer.name
    end
  end

  def calculate_overall_winner
    human.score > computer.score ? human : computer
  end

  def display_winner
    if calculate_winner
      puts "#{calculate_winner} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?(str)
    answer = nil
    loop do
      puts "#{str}"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Please enter y or n."
    end
    answer.downcase == 'y'
  end

  def overall_winner?
    (human.score == GAMES_TO_WIN) || (computer.score == GAMES_TO_WIN)
  end

  def display_overall_winner
    overall_winner = calculate_overall_winner
    puts "#{overall_winner.name} won the game!"
  end

  def update_score
    human.score += 1 if calculate_winner == human.name
    computer.score += 1 if calculate_winner == computer.name
  end

  def choose_bot
    choice = nil
    loop do
      puts ""
      puts "Please choose an opponent: R2D2, Hal, Chappie, Sonny or Number5."
      puts "Feel free to type just the first letter of the bot's name."
      choice = gets.chomp.downcase
      break if (['r2d2', 'hal', 'chappie', 'sonny', 'number5'].include? choice) ||
        (['r', 'h', 'c', 's', 'n'].include? choice)
      puts "Sorry, that's not a valid choice."
    end
    @computer = get_bot(choice)
  end

  def get_bot(choice)
    case choice
    when 'hal'
      Hal.new 
    when 'h'
      Hal.new
    when 'r2d2'
      R2D2.new
    when 'r'
      R2D2.new
    when 'chappie'
      Chappie.new
    when 'c'
      Chappie.new
    when 'sonny'
      Sonny.new
    when 's'
      Sonny.new
    when 'number5'
      Number5.new
    when 'n'
      Number5.new
    end
  end

  def reset_players
    human.score = 0
    human.history = []
    computer.score = 0
    computer.history = []
  end

  def play
    loop do
      display_welcome_message
      choose_bot
      reset_players
      board = Scoreboard.new(human, computer)
      loop do
        computer.choose(human)
        human.choose
        display_moves
        calculate_winner
        display_winner
        update_score
        board.update_board
        board.print_board
        break if overall_winner? || !play_again?("Play another round?")
      end
      display_overall_winner if overall_winner?
      break unless play_again?("Would you like to play another #{GAMES_TO_WIN}-round game?")
    end
    display_goodbye_message
  end
end

RPSGame.new.play