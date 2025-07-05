def starts_one_ends(n)
  if n == 1
    return 2
  end

  starts_with_one = 10**(n - 1)
  ends_with_one = 10**(n - 1)
  starts_and_ends_with_one = 10**(n - 2)

  starts_with_one + ends_with_one - starts_and_ends_with_one
end