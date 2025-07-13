def reverse_delete(s, c)
  chars_to_remove = c.chars.to_set
  result = s.chars.reject { |char| chars_to_remove.include?(char) }.join
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end