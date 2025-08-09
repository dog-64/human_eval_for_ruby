def is_nested?(string)
  second_open = nil
  open_count = 0
  string.each_char.with_index do |ch, i|
    if ch == '['
      open_count += 1
      if open_count == 2
        second_open = i
        break
      end
    end
  end
  return false unless second_open
  close_count = 0
  string.each_char.with_index do |ch, i|
    next if i <= second_open
    close_count += 1 if ch == ']'
    return true if close_count >= 2
  end
  false
end