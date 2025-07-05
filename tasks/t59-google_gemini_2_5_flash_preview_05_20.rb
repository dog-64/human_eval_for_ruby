def largest_prime_factor(n)
  i = 2
  largest_factor = 1
  temp_n = n

  while i * i <= temp_n
    if temp_n % i == 0
      largest_factor = i
      while temp_n % i == 0
        temp_n /= i
      end
    end
    i += 1
  end

  if temp_n > 1
    largest_factor = temp_n
  end

  largest_factor
end