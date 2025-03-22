def reverse_delete(s, c)
  s.delete(c).reverse == s.delete(c) ? [s.delete(c), true] : [s.delete(c), false]