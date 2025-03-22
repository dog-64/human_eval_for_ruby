def correct_bracketing(brackets)
  count = 0
  brackets.each_char do |char|
    count += 1 if char == '('
    if char == ')'
      count -= 1
      return false if count < 0
    end
  end
  count.zero?
end