
def double_the_difference(numbers)
  numbers.sum do |n|
    if n > 0 && n == n.to_i
      n_int = n.to_i
      n_int.odd? ? n_int * n_int : 0
    else
      0
    end
  end
end