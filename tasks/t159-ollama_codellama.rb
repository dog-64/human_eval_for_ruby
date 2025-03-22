def eat(number, need, remaining)
  total_eaten = number + remaining
  carrots_left = remaining - (total_eaten - need)
  return [total_eaten, carrots_left]
end