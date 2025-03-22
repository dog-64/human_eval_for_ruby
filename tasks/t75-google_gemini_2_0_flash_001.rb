def is_multiply_prime?(a)
  return false if a <= 0

  factors = []
  i = 2
  temp = a

  while i * i <= temp
    if temp % i == 0
      if is_prime?(i)
        factors << i
        temp /= i
        while temp % i == 0
          return false
        end
      else
        return false
      end
    else
      i += 1
    end
  end

  if temp > 1
    if is_prime?(temp)
      factors << temp
    else
      return false
    end
  end

  factors.uniq!

  factors.length == 3
end

def is_prime?(n)
  return false if n <= 1
  (2..Math.sqrt(n)).each do |i|
    return false if n % i == 0
  end
  true
end