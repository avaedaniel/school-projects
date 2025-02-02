# author: Mercey Tang

#8. Generate all prime numbers less than a given number and save them to 
# a file (primes.txt).

require_relative 'is_prime.rb'

def generate_primes(limit)
  prime = []
  (2...limit).each do |num|
      prime << num if is_prime(num)
  end
  
  File.open('primes.txt', 'w') do |f|
      prime.each { |num| f.puts num }
  end
  
  prime
end

