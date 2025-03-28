def eat(number, need, remaining)
  total_eaten = number + remaining
  carrots_left = remaining - (need - number).zero?
end