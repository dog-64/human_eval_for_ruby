def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest_extension = extensions.first
  strongest_strength = strongest_extension.count('A-Z') - strongest_extension.count('a-z')

  extensions.each do |extension|
    strength = extension.count('A-Z') - extension.count('a-z')
    if strength > strongest_strength
      strongest_strength = strength
      strongest_extension = extension
    end
  end

  "#{class_name}.#{strongest_extension}"
end