# ask user for 2 numbers
# ask user for an operation to perform
# perform the operation on the numbers
# output the result

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt("Welcome to Calculator! Please enter your name: ")

name = ''
loop do 
  name = gets.chomp
  if name.empty?
    prompt("Please enter a valid name.")
  else
    break
  end
end

prompt("Hi, #{name}")
# main loop
loop do 
  num1 = ''
  loop do
    prompt("Please enter the first number: ")
    num1 = Kernel.gets().chomp()
  
    if valid_number?(num1)
      break
    else
      prompt("Not a valid number.")
    end
  end
  
  num2 = ''
  loop do 
    prompt("Please enter the second number: ")
    num2 = Kernel.gets().chomp()
    
    if valid_number?(num2)
      break
    else
      prompt("Not a valid number.")
    end
  end
  
  operator_prompt = <<-MSG
    What math operation do you want to perform?
    1 add
    2 subtract
    3 multiply
    4 divide
  MSG
  prompt(operator_prompt)
  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    if %w{1 2 3 4}.include?(operator)
      break
    else
      prompt("Please choose 1, 2, 3, 4")
    end
  end
  # if operator == '1'
  #   result = num1.to_i + num2.to_i
  # elsif operator == '2'
  #   result = num1.to_i - num2.to_i
  # elsif operator == '3'
  #   result = num1.to_i * num2.to_i
  # else
  #   result = num1.to_f / num2.to_f
  # end
  
  prompt("#{operation_to_message(operator)} #{num1} and #{num2}...")
  
  result = case operator 
    when '1'
      num1.to_i + num2.to_i
    when '2'
      num1.to_i - num2.to_i
    when '3'
      num1.to_i * num2.to_i
    when '4'
      num1.to_f / num2.to_f
    end
    
  prompt("The result is #{result}")
  
  prompt("Do you want to perform another calculation? (Y to calculate again)")
  
  answer = gets.chomp
  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the Calculator. Goodbye.")