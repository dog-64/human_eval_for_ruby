def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1

  sequence = [1, 3, 2]
  return sequence[0..n] if n <= 2

  (3..n).each do |i|
    if i.even?
      sequence << 1 + i / 2
    else
      next_term = sequence[i - 1] + sequence[i - 2] + sequence[i - 3]
      sequence << next_term
    end
  end

  sequence
end