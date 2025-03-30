
def parse_nested_parens(paren_string)
  groups = paren_string.split(' ')
  groups.map do |group|
    current_depth = 0
    max_depth = 0
    group.each_char do |char|
      current_depth += 1 if char == '('
      current_depth -= 1 if char == ')'
      max_depth = [max_depth, current_depth].max
    end
    max_depth
  end
end

 