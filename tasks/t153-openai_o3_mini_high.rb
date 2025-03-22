def strongest_extension(class_name, extensions)
  return nil if extensions.empty?
  best_ext = extensions.first
  best_strength = best_ext.count("A-Z") - best_ext.count("a-z")
  extensions.each do |ext|
    strength = ext.count("A-Z") - ext.count("a-z")
    if strength > best_strength
      best_strength = strength
      best_ext = ext
    end
  end
  "#{class_name}.#{best_ext}"
end