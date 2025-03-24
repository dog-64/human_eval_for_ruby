def do_algebra(operator, operand)
  result = operand.first
  operator.each_with_index.reduce(result) do |acc, (op, i)|
    operand[i + 1] = eval("#{acc} #{op} #{operand[i + 1]}")
    operand[i + 1]
  end
end