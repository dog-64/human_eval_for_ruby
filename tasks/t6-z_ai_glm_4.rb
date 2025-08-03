
def parse_nested_parens(paren_string)
  return [] if paren_string.empty?
  
  groups = paren_string.split
  result = []
  
  groups.each do |group|
    current_depth = 0
    max_depth = 0
    
    group.each_char do |char|
      if char == '('
        current_depth += 1
        max_depth = current_depth if current_depth > max_depth
      elsif char == ')'
        current_depth -= 1
      end
    end
    
    result << max_depth
  end
  
  result
end