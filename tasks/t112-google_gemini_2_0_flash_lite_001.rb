def reverse_delete(s, c)
  filtered_s = s.delete(c)
  is_palindrome = filtered_s == filtered_s.reverse
  [filtered_s, is_palindrome]
end