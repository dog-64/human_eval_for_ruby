require 'prime'

def largest_prime_factor(n)
  return n unless Prime.prime?(n)
  Prime.prime_division(n)[0]
end