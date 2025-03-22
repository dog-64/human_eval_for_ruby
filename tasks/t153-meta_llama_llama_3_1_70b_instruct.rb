def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest = extensions.max_by do |extension|
    extension.upcase.length - extension.downcase.length
  end

  "#{class_name}.#{strongest}"
end