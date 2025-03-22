def do_algebra(operator, operand)
  expr = operand[0].to_s
  operator.each_with_index do |op, i|
    op = '/' if op == '//'
    expr << op << operand[i + 1].to_s
  end
  eval(expr)
end