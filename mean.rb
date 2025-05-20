# author: Yoyi Liao

# Calculates the mean (average) of a dataset.
# 
# pre: data has to be numerical data type (integer or float)
def mean(data)

  data.reduce {|sum, i| sum + i} / data.size; 

end
