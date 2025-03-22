def reverse_delete(s, c)
  result = ""
  s.each_char do |char|
    if !c.include?(char)
      result += char
    end
  end
  
  if result == result.reverse
    return [result, true]
  else
    return [result, false]
  end
end