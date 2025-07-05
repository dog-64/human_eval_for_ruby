def do_algebra(operator, operand)
  result = operand[0]
  operator.each do |op|
    if op == '+'
      result += operand[1]
    elsif op == '-'
      result -= operand[1]
    elsif op == '*'
      result *= operand[1]
    elsif op == '/'
      result = result.to_f / operand[1]
    elsif op == '//'
      result = result.to_f / operand[1].to_f
    elsif op == '**'
      result **= operand[1]
    end
  end
  result.to_i
end
