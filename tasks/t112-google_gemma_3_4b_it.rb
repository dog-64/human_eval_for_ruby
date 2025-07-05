def reverse_delete(s, c)
  filtered_string = s.gsub(c, '')
  is_palindrome = filtered_string == filtered_string.reverse
  [filtered_string, is_palindrome]
end
