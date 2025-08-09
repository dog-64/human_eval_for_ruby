def reverse_delete(s, c)
  result = s.chars.reject { |ch| c.include?(ch) }.join
  palindrome = result == result.reverse
  [result, palindrome]
end