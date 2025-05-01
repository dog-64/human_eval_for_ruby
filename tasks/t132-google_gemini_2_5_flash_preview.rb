def is_nested?(string)
  open_count = 0
  max_open = 0
  string.each_char do |char|
    if char == '['
      open_count += 1
      max_open = [max_open, open_count].max
    elsif char == ']'
      open_count -= 1
    end
  end
  max_open >= 2
end