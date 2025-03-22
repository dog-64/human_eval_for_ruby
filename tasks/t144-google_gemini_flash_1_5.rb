def simplify(x, n)
  x_num, x_den = x.split("/").map(&:to_i)
  n_num, n_den = n.split("/").map(&:to_i)
  (x_num * n_num) % (x_den * n_den) == 0
end
