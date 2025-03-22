def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest_extension_name = nil
  max_strength = -Float::INFINITY

  extensions.each do |extension|
    strength = extension.count('A-Z') - extension.count('a-z')
    if strength > max_strength
      max_strength = strength
      strongest_extension_name = extension
    end
  end

  "#{class_name}.#{strongest_extension_name}"
end
