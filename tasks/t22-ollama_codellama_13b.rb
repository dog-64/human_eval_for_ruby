def filter_integers(values)
  values.select { |value| value.is_a?(Integer) }
end
filter_integers(['a', 3.14, 5]) # => [5]
filter_integers([1, 2, 3, 'abc', {}, []]) # => [1, 2, 3]
filter_integers([]) # => []
filter_integers([1, 2.5, 3, 4.0]) # => [1, 3]