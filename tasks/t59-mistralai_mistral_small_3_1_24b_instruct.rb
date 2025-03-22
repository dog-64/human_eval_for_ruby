def largest_prime_factor(n)
  def prime?(num)
    return false if num < 2
    (2..Math.sqrt(num)).each do |i|
      return false if num % i == 0
    end
    true
  end

  largest_factor = nil
  (2..Math.sqrt(n)).each do |i|
    while n % i == 0
      largest_factor = i if prime?(i)
      n /= i
    end
  end

  largest_factor || n
end