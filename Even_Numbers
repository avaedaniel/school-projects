# 2. Generate even numbers within a range and save them to a file
  def generate_even_numbers(start_range, end_range, filename)
    even_numbers = []
    (start_range..end_range).each do |num|
      even_numbers << num if num % 2 == 0 # Check if the number is even
    end
    File.open(filename, "w") { |file| file.puts(even_numbers.join("\n")) }
  end
