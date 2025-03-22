def reverse_delete(s, c)
  result = s.delete(c)
  [result, result == result.reverse]
end