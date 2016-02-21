require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  # num.to_i != 0
  num.to_i.to_s == num
end

def number?(num)
  num.to_f.to_s == num || num.to_i.to_s == num
end

def operation_to_message(op)
  gerund = case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Dividing'
          end
  x = "a random line of code"
  
  gerund
end

prompt(MESSAGES['welcome'])

name = ''
loop do 
  name = gets.chomp
  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hi, #{name}!")
# main loop
loop do 
  num1 = ''
  loop do
    prompt(MESSAGES['number_prompt_1'])
    num1 = gets.chomp

    if number?(num1)
      break
    else
      prompt(MESSAGES['valid_num'])
    end
  end

  num2 = ''
  loop do 
    prompt(MESSAGES['number_prompt_2'])
    num2 = Kernel.gets().chomp()
    
    if number?(num2)
      break
    else
      prompt(MESSAGES['valid_num'])
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
      prompt(MESSAGES['valid_op'])
    end
  end

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
  
  prompt(MESSAGES['another_calc'])
  
  answer = gets.chomp
  break unless answer.downcase().start_with?('y')
end

prompt(MESSAGES['goodbye'])