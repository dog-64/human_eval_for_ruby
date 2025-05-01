def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest_ext = extensions.first
  max_strength = 0

  extensions.each do |ext|
    upper_count = ext.count('A-Z')
    lower_count = ext.count('a-z')
    strength = upper_count - lower_count

    if strength > max_strength
      max_strength = strength
      strongest_ext = ext
    end
  end

  "#{class_name}.#{strongest_ext}"
end
