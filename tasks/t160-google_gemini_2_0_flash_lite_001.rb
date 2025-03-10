def do_algebra(operator, operand)
  result = operand[0]
  operator.zip(operand[1..]).each do |op, num|
    case op
    when '+'
      result += num
    when '-'
      result -= num
    when '*'
      result *= num
    when '/'
      result /= num
    when '**'
      result **= num
    end
  end
  result
end