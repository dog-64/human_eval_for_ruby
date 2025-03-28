def do_algebra(operator, operand)
  result = operand.first
  operator.each_with_index do |op, index|
    current_operand = operand[index + 1]
    case op
    when '+' then result += current_operand
    when '-' then result -= current_operand
    when '*' then result *= current_operand
    when '/' then result /= current_operand
    when '**' then result **= current_operand
    end
  end
  result
end