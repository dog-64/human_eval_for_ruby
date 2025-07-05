def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest_extension = extensions[0]
  max_strength = calculate_strength(strongest_extension)

  extensions.each do |extension|
    strength = calculate_strength(extension)
    if strength > max_strength
      max_strength = strength
      strongest_extension = extension
    end
  end

  "#{class_name}.#{strongest_extension}"
end

def calculate_strength(extension)
  uppercase_count = extension.count('A'..'Z')
  lowercase_count = extension.count('a'..'z')
  uppercase_count - lowercase_count
end
