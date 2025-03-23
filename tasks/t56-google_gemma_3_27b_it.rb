
def correct_bracketing(brackets)
  count = 0
  for char in brackets
    if char == '<'
      count += 1
    elsif char == '>'
      count -= 1
    else
      return false
    end
    if count < 0
      return false
    end
  end
  return count == 0
end
