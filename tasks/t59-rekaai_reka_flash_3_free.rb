
def largest_prime_factor(n)
  max_factor = -1
  i = 2
  while i * i <= n
    while n % i == 0
      max_factor = i
      n /= i
    end
    i += 1
  end
  n > 1 ? n : max_factor
end

 