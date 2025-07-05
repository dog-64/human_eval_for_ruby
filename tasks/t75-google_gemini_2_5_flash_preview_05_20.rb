require 'prime'

def is_multiply_prime?(a)
  return false unless a.is_a?(Integer) && a < 100

  prime_factors = Prime.prime_division(a).map(&:first)
  prime_factors.uniq.length == 3 && prime_factors.length == 3
end