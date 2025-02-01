# 6. Percentage: (a / b) * 100
def percentage(a, b)
    (a.to_f / b.to_f) * 100 # Use `to_f` to ensure floating-point division
  end
  
  # Example usage of methods
  if __FILE__ == $PROGRAM_NAME
    # Exponentiation
    puts "2^3 = #{exponent(2, 3)}"
  
    # Generate even numbers and save to file
    generate_even_numbers(1, 10, "even_numbers.txt")
    puts "Even numbers saved to even_numbers.txt"
  
    # Absolute value
    puts "Absolute value of -5 = #{absolute(-5)}"
  
    # Generate square numbers and save to file
    generate_square_numbers(1, 5, "square_numbers.txt")
    puts "Square numbers saved to square_numbers.txt"
  
    # Factorial
    puts "Factorial of 5 = #{factorial(5)}"
  
    # Percentage
    puts "What percentage is 25 of 200? #{percentage(25, 200)}%"
  end