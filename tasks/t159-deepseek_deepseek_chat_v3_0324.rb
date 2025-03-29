def eat(number, need, remaining)
  required = need - number
  if required <= 0
    [number, remaining]
  else
    eaten = [required, remaining].min
    [number + eaten, remaining - eaten]
  end
end