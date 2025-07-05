def reverse_delete(s, c)
  result = s.delete(c)
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end
