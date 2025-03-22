def reverse_delete(s, c)
  result = s.chars.reject { |char| c.include?(char) }.join
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end