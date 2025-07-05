def correct_bracketing(brackets)
  count = 0
  brackets.each_char do |char|
    if char == '('
      count += 1
    elsif char == ')'
      count -= 1
    end
    if count < 0
      return false
    end
  end
  count == 0
end
