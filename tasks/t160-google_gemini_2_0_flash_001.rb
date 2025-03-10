def do_algebra(operator, operand)
  result = operand[0]
  for i in 0...operator.length
    op = operator[i]
    num = operand[i + 1]
    case op
    when '+'
      result += num
    when '-'
      result -= num
    when '*'
      result *= num
    when '/'
      result = result / num
    when '**'
      result = result ** num
    end
  end
  return result
end
