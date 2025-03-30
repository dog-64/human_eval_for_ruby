
def is_sorted?(lst)
  sorted = lst.each_cons(2).all? { |a, b| b >= a }
  no_triple = lst.each_cons(3).none? { |a, b, c| a == b && b == c }
  sorted && no_triple
end

 