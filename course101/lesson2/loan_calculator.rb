# prompt user for loan amount, store in var
# prompt user for APR, store in var
# prompt user for loan length, store in var

# calculate the payment

# output the payment

puts "Enter loan amount:"
p = gets.chomp.to_f

puts "Enter life of loan in years:"
n_years = gets.chomp.to_f

puts "Enter interest rate as an annual rate (APR):"
i_annual = gets.chomp.to_f

i_monthly = i_annual / 12 / 100
n_months = n_years * 12

pmt = p * ((i_monthly * ((1 + i_monthly) ** n_months)) / (((1 + i_monthly) ** n_months) - 1))

puts pmt