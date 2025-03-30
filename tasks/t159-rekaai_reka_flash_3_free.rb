
def eat(number, need, remaining)
  required = need - number
  available = required.positive? ? [required, remaining].max : 0
  [number + available, remaining - available]
end

 