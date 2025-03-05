def is_nested?(string)
  depth = 0
  max_depth = 0

  string.each_char do |char|
    if char == '['
      depth += 1
      max_depth = [max_depth, depth].max
    elsif char == ']'
      depth -= 1
      return false if depth < 0
    end
  end

  depth == 0 && max_depth > 1
end