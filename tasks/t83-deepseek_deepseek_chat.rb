def starts_one_ends(n)
    return 2 if n == 1
    starts_with_one = 10 ** (n - 1)
    ends_with_one = 9 * 10 ** (n - 2)
    starts_with_one + ends_with_one
end