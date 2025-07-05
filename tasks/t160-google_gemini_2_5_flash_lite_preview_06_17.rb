def do_algebra(operator, operand)
  result = operand.first
  operand[1..-1].each_with_index do |opnd, i|
    op = operator[i]
    case op
    when '+'
      result += opnd
    when '-'
      result -= opnd
    when '*'
      result *= opnd
    when '/'
      result /= opnd
    when '**'
      result **= opnd
    end
  end
  result
end