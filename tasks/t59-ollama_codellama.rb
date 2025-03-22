def largest_prime_factor(n)
  return n if is_prime?(n)
  
  (2..Math.sqrt(n)).each do |i|
    break if i * i > n
    next unless n % i == 0
    return largest_prime_factor(i) if is_prime?(i)
  end
  
  return n
end

def is_prime?(n)
  return false if n <= 1 || n.even?
  
  (2..Math.sqrt(n)).each do |i|
    break if i * i > n
    return false if n % i == 0
  end
  
  true
end