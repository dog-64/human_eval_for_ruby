
def is_prime?(n)
  return false if n <= 1
  return true if n <= 3
  return false if n % 2 == 0

  (3..Math.sqrt(n).to_i).step(2) do |i|
    return false if n % i == 0
  end

  true
end

 