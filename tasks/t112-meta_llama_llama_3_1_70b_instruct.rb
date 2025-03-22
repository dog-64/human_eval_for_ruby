def reverse_delete(s, c)
  result = s.gsub(/[#{c}]/, '')
  [result, result == result.reverse]
end