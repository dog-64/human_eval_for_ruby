def generate_even_numbers(a, b)
  ([a, b].min..[a, b].max).select(&:even?)
end