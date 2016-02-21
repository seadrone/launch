# prompt user for loan amount, store in var
# prompt user for APR, store in var
# prompt user for loan length, store in var
# calculate the payment
# output the payment
def to_currency(num)
  format("$%.2f",num)
end

puts "Basic Loan Calculator App\nEnter loan amount:"
p = ''
loop do
  p = gets.chomp
  
  if p.empty? || p.to_f < 0
    puts "Not a valid loan amount. Please try again."
  else
    break
  end
end

n_years = ''
loop do
  puts "Enter life of loan in years:"
  n_years = gets.chomp
  
  if n_years.empty? || n_years.to_i < 0
    puts "Not a valid loan duration. Please try again."
  else
    break
  end
end

i_annual = ''
loop do
  puts "Enter the APR (ex. 4.5 for 4.5% or 6 for 6%):"
  i_annual = gets.chomp

  if i_annual.empty? || i_annual.to_f < 0
    puts "Not a valid APR. Please try again."
  else
    break
  end
end

i_monthly = i_annual.to_f / 12 / 100
n_months = n_years.to_i * 12

pmt = p.to_f * ((i_monthly * ((1 + i_monthly) ** n_months)) / (((1 + i_monthly) ** n_months) - 1))

puts "The monthly payment is #{to_currency(pmt)}."