require 'set'

def reverse_delete(s, c)
  chars = c.chars.to_set
  result = s.chars.reject { |ch| chars.include?(ch) }.join
  [result, result == result.reverse]
end