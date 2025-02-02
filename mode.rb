#mode(data): Finds the mode of a dataset.

# data is a list of numerical values separated by comma
def mode(data)
  freq = {}
  data.each do |num|
    freq[num] = freq.fetch(num, 0) +1
  end
  max_count =0
  mode_values = []
  freq.each do |key, count|
    if count > max_count
      max_count = count
      mode_values = [key]
    elsif count == max_count
      mode_values << key
    end
  end
  mode_values
end

#data = [1, 2, 2, 3, 4, 5, 5, 5, 8, 4, 2]
#puts "Mode: #{mode(data)}"