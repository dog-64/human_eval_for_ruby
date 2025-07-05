def factorial(n)
  return 1 if n == 0
  (1..n).inject(:*)
end

def sum_of_numbers(n)
  (1..n).inject(:+)
end

def f(n)
  result = []
  (1..n).each do |i|
    if i.even?
      result << factorial(i)
    else
      result << sum_of_numbers(i)
    end
  end
  result
end
