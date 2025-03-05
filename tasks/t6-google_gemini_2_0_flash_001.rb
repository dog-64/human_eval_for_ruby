def parse_nested_parens(paren_string)
  return [] if paren_string.empty?

  groups = paren_string.split
  results = []

  groups.each do |group|
    max_depth = 0
    current_depth = 0
    group.each_char do |char|
      if char == '('
        current_depth += 1
        max_depth = [max_depth, current_depth].max
      elsif char == ')'
        current_depth -= 1
      end
    end
    results << max_depth
  end

  results
end