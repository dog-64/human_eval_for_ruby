def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest = extensions.max_by do |ext|
    ext.count("A-Z") - ext.count("a-z")
  end

  "#{class_name}.#{strongest}"
end