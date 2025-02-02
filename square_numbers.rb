# 4. Generate square numbers within a range and save them to a file
  def square_numbers(start_range, end_range)
    square_numbs = []
    (start_range..end_range).each do |num|
      square_numbs << num * num # Square each number
    end
    filename = 'square_numbs.txt'
    File.open(filename, "w") { |file| file.puts(square_numbs.join("\n")) }
    puts "Square numbers between #{start_range} to #{end_range} saved in #{file}"

  end
