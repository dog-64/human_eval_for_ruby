def generate_even_numbers(a, b)
    return [] if a > b
    (a..b).select(&:even?).sort
end