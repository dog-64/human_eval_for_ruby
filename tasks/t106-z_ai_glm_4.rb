
def f(n)
  return [] if n == 0

  result = []
  last_factorial = 1
  last_factorial_index = 0

  (1..n).each do |i|
    if i.odd?
      s = i * (i + 1) / 2
      result << s
    else
      temp = last_factorial * (i - 1) * i
      result << temp
      last_factorial = temp
      last_factorial_index = i
    end
  end

  result
end