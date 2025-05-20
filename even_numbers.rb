# Author: Ava Daniel
# 2. Generate even numbers within a range and save them to a file
  def even_numbers(start_range, end_range)
    even_numbs = []
    (start_range..end_range).each do |num|
      even_numbs << num if num % 2 == 0 # Check if the number is even
    end

    file = 'even_nums.txt'

    File.open(file, "w") { |file| file.puts(even_numbs.join("\n")) }

    puts "Even numbers between #{start_range} to #{end_range} saved in #{file}"
  end

