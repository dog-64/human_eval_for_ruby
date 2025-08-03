
def is_nested?(string)
  stack = []
  pairs = []
  
  string.each_char.with_index do |char, i|
    if char == '['
      stack.push(i)
    elsif !stack.empty?
      open_index = stack.pop
      pairs << [open_index, i]
    end
  end
  
  return false if pairs.size < 2
  
  pairs.sort_by! { |pair| pair[0] }
  has_children = Array.new(pairs.size, false)
  stack = []
  
  pairs.each_with_index do |(open_i, close_i), idx|
    while !stack.empty? && pairs[stack.last][1] < close_i
      stack.pop
    end
    
    if !stack.empty?
      parent_idx = stack.last
      has_children[parent_idx] = true
    end
    
    stack.push(idx)
  end
  
  has_children.any?
end