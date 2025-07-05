def will_it_fly?(q, w)
  is_palindrome = q.is_palindrome?
  total_weight = q.sum

  is_palindrome && total_weight <= w
end
