
def sort_array(arr)
  negatives = arr.select { |x| x < 0 }
  non_negatives = arr.select { |x| x >= 0 }
  
  negatives_sorted = negatives.sort
  non_negatives_sorted = non_negatives.sort_by { |x| [x.to_s(2).count('1'), x] }
  
  negatives_sorted + non_negatives_sorted
end