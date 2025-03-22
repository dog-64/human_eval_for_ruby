def do_algebra(operator, operand)
    result = operand[0]
    operator.each_with_index do |op, index|
        case op
        when '+'
            result += operand[index + 1]
        when '-'
            result -= operand[index + 1]
        when '*'
            result *= operand[index + 1]
        when '/'
            result /= operand[index + 1]
        when '**'
            result **= operand[index + 1]
        end
    end
    result
end