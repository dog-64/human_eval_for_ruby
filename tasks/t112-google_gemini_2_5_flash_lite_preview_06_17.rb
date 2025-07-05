def reverse_delete(s, c)
  result_string = s.delete(c)
  is_palindrome = result_string == result_string.reverse
  [result_string, is_palindrome]
end