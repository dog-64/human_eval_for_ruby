def make_a_pile(n)
  result = []
  current_number = n
  
  (0...n).each do |i|
    result << current_number
    if current_number.odd?
      current_number += 2
    else
      current_number += 2
    end
  end
  
  if n == 1
    result << 3
  end
  
  result
end
