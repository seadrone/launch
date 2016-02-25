VALID_CHOICES = %w(rock paper scissors spock lizard)
user_score = 0
computer_score = 0

def prompt(message)
  puts "=> #{message}"
end

def find_abbreviations(array)
  valid_abbreviations = []
  array.each do |word|
    valid_abbreviations << word.chars.first
  end
  valid_abbreviations
end

def abbreviation_to_word(letter)
  converted_abbreviation =  case letter
                            when 'r'
                              'rock'
                            when 'sc'
                            'scissors'
                            when 'p'
                            'paper'
                            when 'l'
                            'lizard'
                            when 'sp'
                            'spock'
                            end
  converted_abbreviation
end

def win?(first, second)
  (first == 'rock' && ((second == 'scissors') || (second == 'lizard'))) || 
  (first == 'scissors' && ((second == 'paper') || (second == 'lizard'))) || 
  (first == 'paper' && ((second == 'rock') || (second == 'spock' ))) ||
  (first == 'spock' && ((second == 'rock') || (second == 'scissors' ))) ||
  (first == 'lizard' && ((second == 'paper') || (second == 'spock' )))
end

def result(player, computer)
  if win?(player, computer)
    "You win!"
  elsif win?(computer, player)
    "Computer wins!"
  else
    "It's a tie!"
  end
end

loop do 
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = gets.chomp
    
    if VALID_CHOICES.include?(choice) || find_abbreviations(VALID_CHOICES).include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  if choice.length == 1 && choice == 's'
    prompt('Did you mean spock?')
    clarification = gets.chomp
    if clarification.downcase.start_with?('y')
      choice = abbreviation_to_word('sp')
    else
      choice = abbreviation_to_word('sc')
    end
  elsif choice.length == 1
    choice = abbreviation_to_word(choice)
  end

  computer_choice = VALID_CHOICES.sample()
  prompt("You chose: #{choice}. Computer chose: #{computer_choice}.")

  puts score = result(choice, computer_choice)
  
  if score == 'You win!' 
    user_score += 1
  elsif score == 'Computer wins!' 
    computer_score += 1
  end
  
  puts "Your score is: #{user_score}. The computer's score is: #{computer_score}."
  
  # prompt("Do you want to play again?")
  # answer = gets.chomp
  # break unless answer.downcase.start_with?('y')
  
  break if user_score > 4 || computer_score > 4
  
end

if user_score > computer_score
  prompt("Congratulations! You beat the computer.")
else
  prompt("The computer wins. Better luck next time.")
end
prompt("Thanks for playing. Goodbye!")