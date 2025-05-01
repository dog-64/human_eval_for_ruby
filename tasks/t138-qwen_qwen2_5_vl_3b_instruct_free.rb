def is_equal_to_sum_even?(n)
  return false if n < 0 || n % 2 != 0

  (n / 2).times.any? do |i|
    (n - 2 * i).times.any? do |j|
      (n - 2 * i - 2 * j).times.any? do |k|
        (n - 2 * i - 2 * j - 2 * k).times.any? do |l|
          2 * i + 2 * j + 2 * k + 2 * l == n
        end
      end
    end
  end
end
