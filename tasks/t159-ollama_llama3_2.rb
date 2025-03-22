def eat(number, need, remaining)
  total_eaten = [number, need].min + remaining
  carrots_left = total_eaten - number
  [total_eaten, carrots_left]
end