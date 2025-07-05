def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  max_strength = -Float::INFINITY
  strongest_extension_name = nil

  extensions.each do |ext|
    upper_count = ext.count('A-Z')
    lower_count = ext.count('a-z')
    strength = upper_count - lower_count

    if strength > max_strength
      max_strength = strength
      strongest_extension_name = ext
    end
  end

  "#{class_name}.#{strongest_extension_name}"
end