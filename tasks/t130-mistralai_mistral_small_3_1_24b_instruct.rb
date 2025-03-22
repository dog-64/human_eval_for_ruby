def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1

  sequence = [1, 3, 2]
  (2..n).each do |i|
    if i.even?
      sequence << 1 + i / 2
    else
      sequence << sequence[-1] + sequence[-2] + sequence[-3]
    end
  end
  sequence
end