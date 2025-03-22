def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest = extensions.max_by do |extension|
    extension.count('A'..'Z') - extension.count('a'..'z')
  end

  "#{class_name}.#{strongest}"
end