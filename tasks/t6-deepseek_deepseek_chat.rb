def parse_nested_parens(paren_string)
  return [] if paren_string.empty?
  paren_string.split.map do |group|
    depth = 0
    max_depth = 0
    group.chars.each do |char|
      if char == '('
        depth += 1
        max_depth = depth if depth > max_depth
      else
        depth -= 1
      end
    end
    max_depth
  end
end