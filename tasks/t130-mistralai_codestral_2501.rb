def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1
  return [1, 3, 2] if n == 2

  sequence = [1, 3, 2]
  (3..n).each do |i|
    if i.even?
      sequence << 1 + i / 2
    else
      sequence << sequence[i - 1] + sequence[i - 2] + sequence[i + 1]
    end
  end
  sequence
end