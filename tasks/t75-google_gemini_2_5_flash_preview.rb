require 'prime'

def is_multiply_prime?(a)
  return false unless a.is_a?(Integer) && a < 100

  factors = Prime.prime_division(a).map(&:first)

  factors.length == 3 && factors.uniq.length == 3
end
