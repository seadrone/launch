VALID_CHOICES = ['rock', 'paper', 'scissors']

def test_method
end

test_method

def prompt(message)
  puts "=> #{message}"
end

def display_result(player, computer)
  if (player == 'rock' && computer == 'scissors') || 
      (player == 'scissors' && computer == 'paper') || 
      (player == 'paper' && computer == 'rock')
    prompt("You win!")
  elsif (computer == 'rock' && player == 'scissors') || 
      (computer == 'scissors' && player == 'paper') || 
      (computer == 'paper' && player == 'rock')
    prompt("Computer wins!")
  else
    prompt("It's a tie!")
  end
end

loop do 
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp
    
    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end
  
  computer_choice = VALID_CHOICES.sample()
  prompt("You chose: #{choice}. Computer chose: #{computer_choice}.")
  
  display_result(choice, computer_choice)
  
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing. Goodbye!")