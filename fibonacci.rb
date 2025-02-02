#author: Yoyi Liao

# Generate Fibonacci numbers up to a given limit and save them to a file.
def fibonacci(limit)
    fib_sequence = [0, 1]

    while (next_fib = fib_sequence[-1] + fib_sequence[-2]) <= limit
      fib_sequence << next_fib
    end

    File.open('fibonacci.txt', 'w') do |f|
      fib_sequence.each { |num| f.puts num }
    end
    
    fib_sequence
  end    