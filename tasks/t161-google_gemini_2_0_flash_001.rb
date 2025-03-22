def solve(s)
  has_letter = false
  result = ""
  s.each_char do |char|
    if char.match?(/[a-zA-Z]/)
      has_letter = true
      if char == char.upcase
        result += char.downcase
      else
        result += char.upcase
      end
    else
      result += char
    end
  end

  if !has_letter
    return s.reverse
  else
    return result
  end
end