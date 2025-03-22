def is_nested?(string)
  stack = []
  string.each_char do |c|
    if c == '['
      stack << c
    elsif c == ']'
      return false if stack.empty?
      stack.pop
    end
  end
  !stack.empty?
end
puts is_nested?('[[]]') # true
puts is_nested?('[]]]]]]][[[[[]') # false
puts is_nested?('[][]') # false
puts is_nested?('[]') # false
puts is_nested?('[[][]]') # true
puts is_nested?('[[]][[') # true