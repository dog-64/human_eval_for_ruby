
def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  max_strength = -Float::INFINITY
  strongest_ext = nil

  extensions.each do |ext|
    uppercase_count = ext.count('A-Z')
    lowercase_count = ext.count('a-z')
    strength = uppercase_count - lowercase_count

    if strength > max_strength
      max_strength = strength
      strongest_ext = ext
    end
  end

  "#{class_name}.#{strongest_ext}"
end