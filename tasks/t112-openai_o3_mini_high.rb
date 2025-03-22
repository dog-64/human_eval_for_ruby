def reverse_delete(s, c)
  result = s.chars.reject { |char| c.include?(char) }.join
  [result, result == result.reverse]
end