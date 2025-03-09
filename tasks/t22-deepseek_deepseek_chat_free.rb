def filter_integers(values)
  values.select { |v| v.is_a?(Integer) }
end
