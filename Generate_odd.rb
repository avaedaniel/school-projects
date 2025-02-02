# 10. Generate odd numbers within a specified range and save them to a file.
def generate_odd(start_range, end_range)
  odds=[];
  (start_range..end_range).each do |num|
    odds <<num if num % 2 !=0
  end

  file = 'odd_nums.txt'

  File.open(file, "w") { |file| file.puts(odds.join("\n")) }

  puts "Odd numbers between #{start_range} to #{end_range} saved in #{file}"
end

