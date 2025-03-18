def is_nested?(string)
  stack = []
  string.each_char do |char|
    case char
    when '[' then stack << char
    when ']' then stack.pop
    end
  end
  !stack.empty?
end