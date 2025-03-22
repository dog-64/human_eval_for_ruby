def is_nested?(string)
  stack = []
  string.each_char do |c|
    next if c == ']' && stack.empty?
    stack << c
    break unless c == '['
  end
  stack.size > 1
end