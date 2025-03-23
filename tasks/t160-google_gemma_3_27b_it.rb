def do_algebra(operator, operand)
  result = operand[0]
  i = 0
  while i < operator.length
    case operator[i]
    when '+'
      result += operand[i + 1]
    when '-'
      result -= operand[i + 1]
    when '*'
      result *= operand[i + 1]
    when '/'
      result = result.div(operand[i + 1])
    when '**'
      result = result ** operand[i + 1]
    end
    i += 1
  end
  result
end