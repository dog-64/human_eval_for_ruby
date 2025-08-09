def strongest_extension(class_name, extensions)
  return nil if extensions.empty?
  best_extension = nil
  max_strength = -Float::INFINITY
  extensions.each do |ext|
    strength = ext.count('A-Z') - ext.count('a-z')
    if strength > max_strength
      max_strength = strength
      best_extension = ext
    end
  end
  "#{class_name}.#{best_extension}"
end