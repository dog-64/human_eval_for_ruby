def reverse_delete(s, c)
  result = s.chars.reject { |char| c.include?(char) }.join
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end

def reverse_delete(s, c)
  result = s.gsub(/[#{c}]/, '')
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end

def reverse_delete(s, c)
  result = s.delete(c)
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end