def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest_ext = nil
  max_strength = -Float::INFINITY

  extensions.each do |ext|
    strength = ext.count('A-Z') - ext.count('a-z')
    if strength > max_strength
      max_strength = strength
      strongest_ext = ext
    end
  end

  "#{class_name}.#{strongest_ext}"
end