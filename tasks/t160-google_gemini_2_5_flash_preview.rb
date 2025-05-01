def do_algebra(operator, operand)
  expression = operand[0].to_s
  operator.each_with_index do |op, i|
    expression += " #{op} #{operand[i + 1]}"
  end
  eval(expression.gsub('//', '/'))
end