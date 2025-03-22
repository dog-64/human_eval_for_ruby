def do_algebra(operator, operand)
  result = operand[0]
  (0...operator.length).each do |i|
    case operator[i]
    when '+'
      result += operand[i+1]
    when '-'
      result -= operand[i+1]
    when '*'
      result *= operand[i+1]
    when '/'
      result /= operand[i+1]
    when '**'
      result **= operand[i+1]
    end
  end
  result
end
