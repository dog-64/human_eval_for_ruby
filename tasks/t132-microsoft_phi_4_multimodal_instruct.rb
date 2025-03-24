def is_nested?(string)
  depth = 0
  string.each_char do |char|
    depth += 1 if char == '['
    depth -= 1 if char == ']'
    return true if depth < 0
  end
  depth > 0
end