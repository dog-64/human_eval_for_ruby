def reverse_delete(s, c)
  result_string = s.delete(c)
  [result_string, result_string == result_string.reverse]
end
