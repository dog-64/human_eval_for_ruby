def strongest_extension(class_name, extensions)
  return nil if extensions.empty?
  best = nil
  max_strength = -Float::INFINITY
  extensions.each do |ext|
    upper = ext.count('A'..'Z')
    lower = ext.count('a'..'z')
    strength = upper - lower
    if strength > max_strength
      max_strength = strength
      best = ext
    end
  end
  "#{class_name}.#{best}"
end