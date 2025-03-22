def do_algebra(operator, operand)
  result = operand.first
  operator.zip(operand[1..]).each do |op, num|
    case op
    when '+' then result += num
    when '-' then result -= num
    when '*' then result *= num
    when '/' then result /= num
    when '**' then result **= num
    end
  end
  result
end
