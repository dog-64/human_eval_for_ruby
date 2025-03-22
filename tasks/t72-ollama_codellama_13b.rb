def will_it_fly?(q, w)
  return false if q.empty? || q.sum > w
  palindrome?(q) && weight_ok?(q, w)
end

def palindrome?(q)
  q == q.reverse
end

def weight_ok?(q, w)
  q.sum <= w
end