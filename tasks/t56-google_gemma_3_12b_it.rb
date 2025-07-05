def correct_bracketing(brackets)
  count = 0
  brackets.each_char do |char|
    if char == '<'
      count += 1
    elsif char == '>'
      count -= 1
    else
      return false
    end
    return false if count < 0
  end
  count == 0
end
