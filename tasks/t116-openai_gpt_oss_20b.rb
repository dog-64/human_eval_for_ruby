def sort_array(arr)
  negatives, non_negatives = arr.partition { |x| x < 0 }
  sorted_negatives = negatives.sort
  sorted_non_negatives = non_negatives.sort_by { |x| [x.to_s(2).count('1'), x] }
  sorted_negatives + sorted_non_negatives
end