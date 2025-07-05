def will_it_fly?(q, w)
  is_palindrome = q == q.reverse
  weight_ok = q.sum <= w
  is_palindrome && weight_ok
end