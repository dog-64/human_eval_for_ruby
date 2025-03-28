def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest = extensions.max_by do |ext|
    upper = ext.count("A-Z")
    lower = ext.count("a-z")
    upper - lower
  end

  "#{class_name}.#{strongest}"
end