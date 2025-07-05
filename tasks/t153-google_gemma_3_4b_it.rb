def strongest_extension(class_name, extensions)
  if extensions.empty?
    return nil
  end

  strongest = nil
  max_strength = -1

  extensions.each do |extension|
    strength = 0
    extension.each_char do |char|
      strength += 1 if char.match?(/[A-Z]/)
      strength += 1 if char.match?(/[a-z]/)
    end

    if strength > max_strength
      max_strength = strength
      strongest = extension
    end
  end

  return "#{class_name}.#{strongest}"
end
