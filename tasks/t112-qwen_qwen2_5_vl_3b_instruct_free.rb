def reverse_delete(s, c)
  result = s.chars - c.chars
  result.reverse == result ? [result, true] : [result, false]
end