class Player
  attr_accessor :move, :name
  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = ""
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
      puts "Please choose rock, paper, or scissors:"
      choice = gets.chomp
      break if ['rock', 'paper', 'scissors'].include?(choice)
      puts "Sorry that's not a valid choice."
    end
    self.move = choice
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Computer'].sample
  end
  
  def choose
    self.move = ['rock', 'paper', 'scissors'].sample
  end
end

class RPSGame
  attr_accessor :human, :computer
  def initialize
    @human = Human.new
    @computer = Computer.new
  end
  
  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors"
  end
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye."
  end
  
  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    
    case human.move
    when "rock"
      puts "It's a tie!" if computer.move == "rock"
      puts "#{human.name} wins!" if computer.move == "scissors"
      puts "#{computer.name} wins." if computer.move == "paper"
    when "paper"
      puts "It's a tie!" if computer.move == "paper"
      puts "#{human.name} wins!" if computer.move == "rock"
      puts "#{computer.name} wins." if computer.move == "scissors"
    when "scissors"
      puts "It's a tie!" if computer.move == "scissors"
      puts "#{human.name} wins!" if computer.move == "paper"
      puts "#{computer.name} wins." if computer.move == "rock"
    end
    
  end
  
  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include? answer.downcase
      puts "Sorry you must choose y or n."
    end
    return true if answer == 'y'
    return false
  end
  
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play