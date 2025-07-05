def eat(number, need, remaining)
  total_eaten = number + [remaining, need - number].min
  carrots_left = remaining - [remaining, need - number].min
  [total_eaten, carrots_left]
end
