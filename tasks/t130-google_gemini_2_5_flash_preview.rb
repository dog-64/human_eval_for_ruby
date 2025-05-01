def tri(n)
  if n == 0
    return [1]
  end

  sequence = [1, 3]

  (2..n).each do |i|
    if i.even?
      sequence << 1 + i / 2
    else
      sequence << sequence[i - 1] + sequence[i - 2] + sequence[i + 1]
    end
  end

  sequence[0..n]
end