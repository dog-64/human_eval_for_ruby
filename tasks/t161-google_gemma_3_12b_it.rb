def solve(s)
  if s.empty?
    return ""
  end

  has_letters = false
  s.each_char do |char|
    if char.match?(/[a-zA-Z]/)
      has_letters = true
      break
    end
  end

  if !has_letters
    return s.reverse
  end

  result = ""
  s.each_char do |char|
    if char.match?(/[a-zA-Z]/)
      if char.match?(/[a-z]/)
        result += char.upcase
      else
        result += char.downcase
      end
    else
      result += char
    end
  end

  result
end
