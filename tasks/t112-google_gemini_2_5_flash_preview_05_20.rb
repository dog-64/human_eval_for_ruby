def reverse_delete(s, c)
  chars_to_delete = c.chars.to_set
  result_string = s.chars.reject { |char| chars_to_delete.include?(char) }.join
  is_palindrome = result_string == result_string.reverse
  [result_string, is_palindrome]
end