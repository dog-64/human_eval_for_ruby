def tri(n)
  return [1] if n == 0

  sequence = [1, 3]
  (2..n).each do |i|
    if i.even?
      sequence << (1 + i / 2)
    else
      sequence << (sequence[i - 1] + sequence[i - 2] + sequence[i - 3])
    end
  end
  sequence
end