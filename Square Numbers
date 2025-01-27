# 4. Generate square numbers within a range and save them to a file
  def generate_square_numbers(start_range, end_range, filename)
    square_numbers = []
    (start_range..end_range).each do |num|
      square_numbers << num * num # Square each number
    end
    File.open(filename, "w") { |file| file.puts(square_numbers.join("\n")) }
  end
