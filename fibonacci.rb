#author: Yoyi Liao

# Generate Fibonacci numbers up to a given limit and save them to a file.
def fibonacci(limit)
    fib_sequence = [0, 1]

    while (next_fib = fib_sequence[-1] + fib_sequence[-2]) <= limit
      fib_sequence << next_fib
    end
    
    file = 'fibonacci.txt'

    File.open(filename, 'w') do |file|
      fib_sequence.each { |num| file.puts num }
    end
    
    puts "Fibonacci numbers up to #{limit} saved in #{filename}"
  end    