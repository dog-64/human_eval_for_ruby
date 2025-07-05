def starts_one_ends(n)
  if n == 1
    return 2
  end
  
  starts_with_one = 9 * (10**(n - 1))
  ends_with_one = 9 * (10**(n - 1))
  
  if n == 2
    return 18
  end
  
  if n == 3
    return 180
  end
  
  starts_with_one_and_ends_with_one = 9 * (10**(n - 2))
  
  return starts_with_one + ends_with_one - starts_with_one_and_ends_with_one
end
