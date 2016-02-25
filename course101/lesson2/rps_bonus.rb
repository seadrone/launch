VALID_CHOICES = %w(rock paper scissors spock lizard)

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

def display_result(player, computer)
  if win?(player, computer)
    prompt("You win!")
  elsif win?(computer, player)
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

  display_result(choice, computer_choice)
  
  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing. Goodbye!")