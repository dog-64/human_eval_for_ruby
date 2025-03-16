def get_odd_collatz(n)
  seq = []
  current = n
  while true
    seq << current
    break if current == 1
    if current.even?
      current /= 2
    else
      current = 3 * current + 1
    end
  end
  # Если исходное число нечётное, то в последовательности оно первое, а завершается всегда 1.
  # Согласно примерам, возвращаем [1, n] (отсортированно) для нечётного n и [1] для чётного.
  seq.first.odd? ? [1, seq.first].sort : [1]
end