
def special_factorial(n)
    return 1 if n == 1
    (1..n).inject(:*)
end