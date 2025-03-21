def eat(number, need, remaining)
  total_eaten = [number + remaining, need].min
  carrots_left = remaining - (total_eaten - number)
  [total_eaten, carrots_left]
end