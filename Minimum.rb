#10. minimum(data): Returns the smallest value from a set of numbers.
def minimum (data)
  min = data [0]
  data.each do |num|
    min = num if num < min
  end
  min
end

# data = [20, 10, 30, 40, 6, 2, 1]
# puts "Minimum: #{minimum(data)}"