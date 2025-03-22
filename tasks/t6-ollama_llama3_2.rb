def parse_nested_parens(paren_string)
  return [] if not paren_string
  stack = []
  max_depths = []
  i = 0
  while i < paren_string.length do
    if paren_string[i] == '(' then
      stack.push(1)
    elsif paren_string[i] == ')' then
      depth = stack.pop
      max_depths.push(depth) if not stack.empty?
    end
    i += 1
  end
  max_depths
end