# Custom Ruby methods

# 1. Exponentiation: a^b
def exponent(a, b)
    result = 1
    b.times { result *= a } # Multiply `a` by itself `b` times
    result
  end
  
  # 2. Generate even numbers within a range and save them to a file
  def generate_even_numbers(start_range, end_range, filename)
    even_numbers = []
    (start_range..end_range).each do |num|
      even_numbers << num if num % 2 == 0 # Check if the number is even
    end
    File.open(filename, "w") { |file| file.puts(even_numbers.join("\n")) }
  end
  
  # 3. Absolute value
  def absolute(a)
    a < 0 ? -a : a # If `a` is negative, return `-a`; otherwise, return `a`
  end
  
  # 4. Generate square numbers within a range and save them to a file
  def generate_square_numbers(start_range, end_range, filename)
    square_numbers = []
    (start_range..end_range).each do |num|
      square_numbers << num * num # Square each number
    end
    File.open(filename, "w") { |file| file.puts(square_numbers.join("\n")) }
  end
  
  # 5. Factorial: n!
  def factorial(n)
    return 1 if n == 0 || n == 1 # Base case: 0! = 1! = 1
    result = 1
    (2..n).each { |num| result *= num } # Multiply all numbers from 2 to n
    result
  end
  
  # 6. Percentage: (a / b) * 100
  def percentage(a, b)
    raise ArgumentError, "Denominator (b) cannot be zero" if b == 0
    (a * 100) / b
  end