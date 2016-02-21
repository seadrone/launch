# 1. a method that returns the sum of two integers
# Method takes two integer arguments, adds them, and returns the sum

# 2. a method that takes an array of strings, and returns a string that is all those strings concatenated together
# Given an array of strings
# Iterate over each string in the array
# Append each subsequent item in the array to the new array
# After iterating over the entire array return the new array

# START
# SET iterator = 1
# WHILE iterator < length of orig_array
#   SET new_array << item
#   iterator += 1
# PRINT new_array
# END

# 3. a method that takes an array of integers, and returns a new array with every other element
# Given an array of integers
# Iterate over each integer in the array
# If the index is odd append it to the new array
# return the new array

# START
# SET iterator = 1
# WHILE iterator < length of orig_array
#   IF remainder of index and 2 == 0
#     append to new_array
#   END
#   iterator += 1
# PRINT new_array
# END