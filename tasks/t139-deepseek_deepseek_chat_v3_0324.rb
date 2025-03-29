def special_factorial(n)
  (1..n).reduce(1) do |result, i|
    result * (1..i).reduce(1, :*)
  end
end