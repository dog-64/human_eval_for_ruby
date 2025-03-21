
def strongest_extension(class_name, extensions)
    return nil if extensions.empty?
    max_strength = -1
    strongest_extension = nil
    extensions.each do |extension|
        strength = extension.count("A-Z") - extension.count("a-z")
        if strength > max_strength
            max_strength = strength
            strongest_extension = extension
        end
    end
    "#{class_name}.#{strongest_extension}"
end