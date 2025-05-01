require 'prime'

def prime_fib(n)
  raise ArgumentError, "Input must be a positive integer" unless n.is_a?(Integer) && n > 0

  count = 0
  a, b = 1, 2

  loop do
    if b.prime?
      count += 1
      return b if count == n
    end
    a, b = b, a + b
  end
end