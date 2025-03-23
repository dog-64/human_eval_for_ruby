
def correct_bracketing(brackets)
  count = 0
  for bracket in brackets
    if bracket == '('
      count += 1
    elsif bracket == ')'
      count -= 1
    end
    if count < 0
      return false
    end
  end
  return count == 0
end
