def tri(n)
  return [1] if n == 0
  return [1, 3] if n == 1

  tribonacci_sequence = [1, 3]
  (2..n).each do |i|
    if i.even?
      tribonacci_sequence << 1 + (i / 2)
    else
      tribonacci_sequence << tribonacci_sequence[i - 1] + tribonacci_sequence[i - 2] + tribonacci_sequence[i + 1]
    end
  end
  tribonacci_sequence
end
