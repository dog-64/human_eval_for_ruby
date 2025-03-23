def eat(number, need, remaining)
  eat_amount = [need - number, remaining].min
  total_eaten = number + eat_amount
  carrots_left = remaining - eat_amount
  [total_eaten, carrots_left]
end