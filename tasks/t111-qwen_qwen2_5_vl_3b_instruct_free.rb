def histogram(text)
  text.downcase.scan(/[a-z]/).group_by(&:itself).transform_values(&:count).select { |_, count| count > 0 }
end