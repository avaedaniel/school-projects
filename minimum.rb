# author: Mercey Tang

#10. minimum(data): Returns the smallest value from a set of numbers.
# data is a list of numerical values separated by comma

def minimum(data)
  min = data [0]
  data.each do |num|
    min = num if num < min
  end
  min
end