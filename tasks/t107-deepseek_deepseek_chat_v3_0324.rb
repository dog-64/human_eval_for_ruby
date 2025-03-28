def even_odd_palindrome(n)
  even_count = 0
  odd_count = 0
  (1..n).each do |num|
    if num.to_s == num.to_s.reverse
      num.even? ? even_count += 1 : odd_count += 1
    end
  end
  [even_count, odd_count]
end