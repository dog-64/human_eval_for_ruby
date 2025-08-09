def parse_nested_parens(paren_string)
  return [] if paren_string.strip.empty?
  paren_string.split(/\s+/).map do |group|
    depth = 0
    max_depth = 0
    group.each_char do |ch|
      if ch == '('
        depth += 1
        max