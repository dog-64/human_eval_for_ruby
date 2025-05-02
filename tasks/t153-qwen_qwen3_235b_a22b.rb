def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  max_strength = -Float::INFINITY
  strongest = nil

  extensions.each do |ext|
    upper = 0
    lower = 0
    ext.each_char do |c|
      if c.match?(/[A-Z]/)
        upper += 1
      elsif c.match?(/[a-z]/)
        lower += 1
      end
    end
    strength = upper - lower

    if strength > max_strength
      max_strength = strength
      strongest = ext
    end
  end

  "#{class_name}.#{strongest}"
end