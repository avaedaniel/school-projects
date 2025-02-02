# 7. median(data): Calculates the median of a dataset.

# data is a list of numerical values separated by comma
def median(data)
  sortD = data.sort
  length = sortD.length
  midL = length/2

if length.odd?
  sortD[midL]
else
  (sortD[midL-1] + sortD[midL])/2.0
end
end

