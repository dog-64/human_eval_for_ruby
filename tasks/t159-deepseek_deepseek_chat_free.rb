def eat(number, need, remaining)
  required = [need - number, remaining].min
  total_eaten = number + required
  carrots_left = remaining - required
  [total_eaten, carrots_left]
end
