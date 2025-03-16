def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  strongest = extensions.max_by do |ext|
    ext.count { |c| c.upcase == c } - ext.count { |c| c.downcase == c }
  end

  "#{class_name}.#{strongest}"
end