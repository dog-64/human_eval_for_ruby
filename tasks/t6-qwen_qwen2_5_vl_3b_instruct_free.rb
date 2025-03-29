def parse_nested_parens(paren_string)
  paren_string.split(' ').map do |group|
    max_depth = 0
    depth = 0
    group.chars.each do |char|
      if char == '('
        depth += 1
        max_depth = [max_depth, depth].max
      elsif char == ')'
        depth -= 1
      end
    end
    [max_depth]
  end
end