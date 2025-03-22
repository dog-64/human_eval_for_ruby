def even_odd_palindrome(n)
  even_count = 0
  odd_count = 0
  (1..n).each do |i|
    s = i.to_s
    if s == s.reverse
      if i % 2 == 0
        even_count += 1
      else
        odd_count += 1
      end
    end
  end
  return [even_count, odd_count]
end