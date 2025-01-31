# 10. Generate odd numbers within a specified range and save them to a file.
def generate_odds (start_range, end_range, filename)
  odds=[];
  (start_range..end_range).each do |num|
    odds <<num if num % 2 !=0
  end
  File.write(filename, odds.join(", "))
end

#generate_odds(0, 50,"oddList.txt")
