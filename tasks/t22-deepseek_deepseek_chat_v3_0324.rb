def filter_integers(values)
  values.select { |v| v.is_a?(Integer) && !v.is_a?(TrueClass) && !v.is_a?(FalseClass) }
end