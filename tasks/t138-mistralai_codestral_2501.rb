def is_equal_to_sum_even?(n)
  return false if n < 8 || n.odd?

  (2..n / 4).each do |i|
    (i..n / 3).each do |j|
      (j..n / 2).each do |k|
        l = n - i - j - k
        return true if l > 0 && l.even?
      end
    end
  end

  false
end