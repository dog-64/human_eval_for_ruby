def digit_sum(s)
  s.each_char.sum do |char|
    if char >= 'A' && char <= 'Z'
      char.ord
    else
      0
    end
  end
end