def do_algebra(operator, operand)
  result = operand[0]
  operator.each_with_index do |op, i|
    result = case op
             when '+'
               result + operand[i + 1]
             when '-'
               result - operand[i + 1]
             when '*'
               result *= operand[i + 1]
             when '/'
               result /= operand[i + 1]
             when '**'
               result **= operand[i + 1]
             else
               raise "Invalid operator: #{op}"
             end
  end
  result
end