class Scoreboard
  attr_accessor :board
  attr_reader :p1, :p2

  def initialize(player1, player2)
    @p1 = player1
    @p2 = player2
    initialize_board
  end

  def initialize_board
    @board = {p1_history: ["#{p1.name}".slice(0, 10).center(10, ' ')],
      divider: ['-' * 10],
      p2_history: ["#{p2.name}".center(10, ' ')]
    }
  end

  def update_board
    @board[:p1_history].push('|').push("#{p1.move}".slice(0, 2).center(4, ' '))
    @board[:divider].push('+').push('-' * 4)
    @board[:p2_history].push('|').push("#{p2.move}".slice(0, 2).center(4, ' '))
  end

  def print_board
    puts ""
    puts ""
    puts "** SCOREBOARD **"
    puts ""
    puts @board[:p1_history].push('|').push("#{p1.score}".center(4, ' ')).join
    puts @board[:divider].push('+').push("-" * 4).join
    puts @board[:p2_history].push('|').push("#{p2.score}".center(4, ' ')).join
    @board.each_value {|arr| arr.slice!(-2, 2)}
    puts ""
    puts ""
  end

end

class Player
  attr_accessor :move, :name, :score, :history
  def initialize
    set_name
    @score = 0
  end

  def set_move_choice(choice)
    case choice
    when 'rock'
      self.move = Rock.new
    when 'paper'
      self.move = Paper.new
    when 'scissors'
      self.move = Scissors.new
    when 'lizard'
      self.move = Lizard.new
    when 'spock'
      self.move = Spock.new
    end
  end
end

class Move
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']
  attr_reader :defeats

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
    self.defeats.include?(other_move.to_s)
  end

  def to_s
    @value
  end

end

class Rock < Move
  def initialize
    @value = 'rock'
    @defeats = ['scissors', 'lizard']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @defeats = ['rock', 'spock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @defeats = ['paper', 'lizard']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @defeats = ['paper', 'spock']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @defeats = ['scissorss', 'rock']
  end
end

class Human < Player
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
    set_move_choice(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number5'].sample
  end

  def choose
    self.move = set_move_choice(Move::VALUES.sample)
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
    puts "Hi #{human.name}! Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "The first player to win #{GAMES_TO_WIN} games wins. Good luck."
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Goodbye!"
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

  def play_again?
    answer = nil
    loop do
      puts "Play another round? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Please enter y or n."
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def overall_winner?
    (human.score == GAMES_TO_WIN) || (computer.score == GAMES_TO_WIN)
  end

  def display_overall_winner
    overall_winner = calculate_overall_winner
    puts "#{overall_winner.name} won the game!"
  end

  def overall_play_again?
    answer = nil
    loop do
      puts "Would you like to play another game? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Please enter y or n."
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def update_score
    human.score += 1 if calculate_winner == human.name
    computer.score += 1 if calculate_winner == computer.name
  end

  # def display_score
    # puts "#{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  # end

  def play
    loop do
      display_welcome_message
      human.score = 0
      computer.score = 0
      board = Scoreboard.new(human, computer)
      loop do
        human.choose
        computer.choose
        display_moves
        calculate_winner
        display_winner
        update_score
        board.update_board
        board.print_board
        break if overall_winner? || !play_again?
      end
      display_overall_winner if overall_winner?
      break unless overall_play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play