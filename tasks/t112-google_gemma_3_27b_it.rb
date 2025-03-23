
def reverse_delete(s, c)
  result = s.gsub(/[#{c}]/, '')
  is_palindrome = result == result.reverse
  [result, is_palindrome]
end
