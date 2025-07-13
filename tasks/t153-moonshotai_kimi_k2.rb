def strongest_extension(class_name, extensions)
  return nil if extensions.empty?
  
  strongest = extensions.max_by do |ext|
    uppercase = ext.count('A-Z')
    lowercase = ext.count('a-z')
    uppercase - lowercase
  end
  
  "#{class_name}.#{strongest}"
end