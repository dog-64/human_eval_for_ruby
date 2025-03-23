
def filter_integers(values)
  result = []
  values.each do |value|
    result << value if value.is_a?(Integer)
  end
  result
end
