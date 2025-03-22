def monotonic?(arr)
  increasing = true
  decreasing = true

  arr.each_cons(2) do |a, b|
    increasing = false if a > b
    decreasing = false if a < b
  end

  increasing || decreasing
end