def do_algebra(operator, operand)
  result = operand[0]
  (1...operand.length).each do |i|
    case operator[i - 1]
    when '+'
      result += operand[i]
    when '-'
      result -= operand[i]
    when '*'
      result *= operand[i]
    when '/'
      result = (result / operand[i]).to_i
    when '**'
      result = (result ** operand[i]).to_i
    end
  end
  result
end
