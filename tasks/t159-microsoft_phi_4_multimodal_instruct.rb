def eat(number, need, remaining)
  total_eaten = [number + remaining, need].min
  carrots_left = remaining + number - total_eaten
  [total_eaten, carrots_left.clamp(0, remaining + number)]
end
