def is_nested?(string)
  count = 0
  nested = false
  string.each_char do |char|
    if char == '['
      count += 1
    elsif char == ']'
      count -= 1
    end

    if count < 0
      return false
    end

    if count > 1
      nested = true
    end
  end

  if count != 0
    return false
  end

  return nested
end