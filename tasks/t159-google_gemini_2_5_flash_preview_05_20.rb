def eat(number, need, remaining)
  needed_to_reach_goal = need - number
  
  if needed_to_reach_goal <= 0
    [number, remaining]
  else
    if remaining >= needed_to_reach_goal
      total_eaten = number + needed_to_reach_goal
      carrots_left = remaining - needed_to_reach_goal
      [total_eaten, carrots_left]
    else
      total_eaten = number + remaining
      carrots_left = 0
      [total_eaten, carrots_left]
    end
  end
end