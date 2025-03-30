
def closest_integer(value)
  num = Float(value)
  if (num * 2).to_i == num * 2
    num >= 0 ? (num + 0.5).to_i : (num - 0.5).to_i
  else
    num.round
  end
end

 