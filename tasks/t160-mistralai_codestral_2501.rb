def do_algebra(operator, operand)
  result = operand[0]
  operator.each_with_index do |op, i|
    case op
    when '+'
      result += operand[i + 1]
    when '-'
      result -= operand[i + 1]
    when '*'
      result *= operand[i + 1]
    when '/'
      result /= operand[i + 1]
    when '**'
      result **= operand[i + 1]
    when '//'
      result = result.div(operand[i + 1])
    end
  end
  result
end