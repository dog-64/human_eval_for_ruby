def filter_integers(values)
  values.select { |x| x.is_a?(Integer) }
end