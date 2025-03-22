def parse_nested_parens(paren_string)
  return [] if paren_string.empty?

  paren_string.split.map do |group|
    depth = 0
    max_depth = 0
    group.each_char do |char|
      if char == '('
        depth += 1
        max_depth = [max_depth, depth].max
      elsif char == ')'
        depth -= 1
      end
    end
    max_depth
  end
end