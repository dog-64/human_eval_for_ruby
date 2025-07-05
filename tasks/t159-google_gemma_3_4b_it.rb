class CarrotEater
  def eat(number, need, remaining)
    eaten = number
    if remaining >= need - number
      eaten += need - number
      remaining -= need - eaten
    else
      eaten += remaining
      remaining = 0
    end
    [eaten, remaining]
  end
end
