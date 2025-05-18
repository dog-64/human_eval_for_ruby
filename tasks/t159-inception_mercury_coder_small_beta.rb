def eat(number, need, remaining)
  total_eaten = [number + (need - number), number + remaining].min
  carrots_left = remaining - [need - number, remaining].min
  [total_eaten, carrots_left]
end