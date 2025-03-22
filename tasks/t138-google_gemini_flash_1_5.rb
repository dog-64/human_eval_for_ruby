def is_equal_to_sum_even?(n)
  return false if n < 8 || n % 2 != 0
  (2..n-6).each do |a|
    (2..n-a-4).each do |b|
      (2..n-a-b-2).each do |c|
        d = n - a - b - c
        return true if d > 1 && d % 2 == 0
      end
    end
  end
  false
end
