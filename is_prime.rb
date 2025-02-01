#9.is_prime(n): Checks if a given number n is a prime number.
def is_prime(n)
  return false if n<2
  (2...n).each do |i|
    return false if n % i ==0
  end
  true
end

#n = 200
#puts "Median: #{is_prime(n)}" 

