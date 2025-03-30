
def do_algebra(operator, operand)
  expression = operand.first.to_s
  operand.drop(1).each_with_index do |num, i|
    expression += " #{operator[i]} #{num}"
  end
  eval(expression)
end

 