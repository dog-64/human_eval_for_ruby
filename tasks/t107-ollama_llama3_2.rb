def even_odd_palindrome(n)
  (2..n).map { |i| i.to_s == i.to_s.reverse }.sum
end