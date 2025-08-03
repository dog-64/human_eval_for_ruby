
_algebra(operator, operand)
  expression = operand[0].to_s
  operator.each_with_index do |op, i|
    op_str = op == '//' ? '/' : op
    expression += " #{op_str} #{operand[i+1]}"
  end
  eval(expression)
end