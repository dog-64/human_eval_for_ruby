def is_nested?(string)
  return false if string.empty?

  open_count = 0
  string.each_char do |char|
    if char == '['
      open_count += 1
    elsif char == ']'
      open_count -= 1
    end

    return true if open_count > 1
  end
  false
end