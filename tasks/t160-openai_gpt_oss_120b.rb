def do_algebra(operators, operands)
  precedence = { '**' => 3, '*' => 2, '/' => 2, '//' => 2, '+' => 1, '-' => 1 }
  right_assoc = { '**' => true }

  output = []
  op_stack = []

  tokens = []
  operands.each_with_index do |num, i|
    tokens << num
    tokens << operators[i] if i < operators.size
  end

  tokens.each do |token|
    if token.is_a?(Integer)
      output << token
    else
      while !op_stack.empty?
        top = op_stack[-1]
        break if (right_assoc[token] && precedence[token] < precedence[top]) ||
                 (!right_assoc[token] && precedence[token] <= precedence[top])
        output << op_stack.pop
      end
      op_stack << token
    end
  end

  output.concat(op_stack.reverse)

  stack = []
  output.each do |tok|
    if tok.is_a?(Integer)
      stack << tok
    else
      b = stack.pop
      a = stack.pop
      result = case tok
               when '+'
                 a + b
               when '-'
                 a - b
               when '*'
                 a * b
               when '/', '//'
                 a / b
               when '**'
                 a ** b
               end
      stack << result
    end
  end

  stack.first
end