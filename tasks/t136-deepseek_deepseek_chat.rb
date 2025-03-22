def largest_smallest_integers(lst)
    negatives = lst.select { |x| x < 0 }
    positives = lst.select { |x| x > 0 }
    
    a = negatives.empty? ? nil : negatives.max
    b = positives.empty? ? nil : positives.min
    
    [a, b]
end