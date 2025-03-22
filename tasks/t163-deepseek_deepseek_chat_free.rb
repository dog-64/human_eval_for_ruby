def generate_even_numbers(a, b)
    start, finish = [a, b].min, [a, b].max
    start += 1 if start.odd?
    finish -= 1 if finish.odd?
    start > finish ? [] : (start..finish).step(2).to_a
end