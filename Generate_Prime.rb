#8. Generate all prime numbers less than a given number and save them to a file.

require_relative 'Prime.rb'

def generate_primes(limit, filename)
  prime =[]
  (2...limit).each do |num|
    prime <<num if is_prime(num)
end
  File.write(filename,prime.join(","))
end

#generate_primes(20,"primeList.txt")
