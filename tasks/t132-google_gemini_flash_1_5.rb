def is_nested?(string)
  return false if string.empty?
  count = 0
  nested = false
  string.each_char do |char|
    if char == '['
      count += 1
    elsif count > 0
      count -= 1
      nested = true if count > 0
    end
  end
  nested && count == 0
end
