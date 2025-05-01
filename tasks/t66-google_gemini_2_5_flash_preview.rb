def digit_sum(s)
  s.chars.sum do |char|
    if char >= 'A' && char <= 'Z'
      char.ord
    else
      0
    end
  end
end