
def is_nested?(string)
  stack = []
  pairs = []
  string.each_char.with_index do |char, i|
    char == '[' ? stack << i : pairs << [stack.pop, i]
  end

  pairs.any? { |i, j| pairs.any? { |k, l| i < k && k < l && l < j } }
end

 