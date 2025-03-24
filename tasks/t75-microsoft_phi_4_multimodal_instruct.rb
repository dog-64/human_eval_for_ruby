require 'prime'

def is_multiply_prime?(a)
  return false if a < 2 || a >= 100
  count = 0
  a.prime_division.each do |_, exp|
    count += 1 if exp == 1
  end
  count == 3
end