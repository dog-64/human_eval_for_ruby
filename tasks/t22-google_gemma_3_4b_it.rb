def filter_integers(values)
  result = []
  values.each do |value|
    if value.is_a?(Integer)
      result << value
    end
  end
  result
end
