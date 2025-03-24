require 'prime'

def factorize(n)
  return [] if n == 1
  n = n.positive? ? n : n * -1
  Prime.prime_division(n).map { |p, e| p * [e] }.flatten(1).sort
end