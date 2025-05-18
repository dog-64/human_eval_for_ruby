

def prime_fib(n)
  if n < 1
    raise ArgumentError, "n must be a positive integer"
  end

  def is_prime(num)
    return false if num < 2
    return true if num == 2
    return false if num.even?
    sqrt = Math.sqrt(num).to_i
    (3..sqrt).step(2) do |i|
      return false if num % i == 0
    end
    true
  end

  a, b = 0, 1
  count = 0
 