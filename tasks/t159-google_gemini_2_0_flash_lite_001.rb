def eat(number, need, remaining)
  eat_more = need - number
  if eat_more <= 0
    [need, remaining]
  elsif eat_more <= remaining
    [need, remaining - eat_more]
  else
    [number + remaining, 0]
  end
end