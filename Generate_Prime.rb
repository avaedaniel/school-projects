#8. Generate all prime numbers less than a given number and save them to a file.

require_relative 'is_prime.rb'

def generate_primes(limit)
  prime =[]
  (2...limit).each do |num|
    prime <<num if is_prime(num)
end

  filename = 'primes.txt'
  File.write(filename,prime.join(","))
end


