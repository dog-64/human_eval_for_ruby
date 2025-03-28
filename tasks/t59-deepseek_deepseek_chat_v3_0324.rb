def largest_prime_factor(n)
  return 2 if n.even?

  largest_factor = 1
  i = 3
  max_factor = Math.sqrt(n).to_i

  while i <= max_factor
    if n % i == 0
      largest_factor = i
      n /= i while n % i == 0
      max_factor = Math.sqrt(n).to_i
    end
    i += 2
  end

  n > 1 ? n : largest_factor
end