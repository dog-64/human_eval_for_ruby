def strongest_extension(class_name, extensions)
  return nil if extensions.empty?
  strongest = extensions.max_by do |ext|
    ext.chars.count { |c| c == c.upcase } - ext.chars.count { |c| c == c.downcase }
  end
  "#{class_name}.#{strongest}"
end