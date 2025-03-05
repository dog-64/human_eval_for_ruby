def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest = extensions.max_by { |ext| ext.count(->(c) { c.upcase? }) - ext.count(->(c) { c.downcase? }) }
  "#{class_name}.#{strongest}"
end