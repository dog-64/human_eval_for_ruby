def special_factorial(n)
    factorial = ->(x) { x <= 1 ? 1 : x * factorial.call(x - 1) }
    (1..n).reduce(1) { |acc, i| acc * factorial.call(i) }
end