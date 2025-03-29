def strongest_extension(class_name, extensions)
  return nil if extensions.empty?

  extensions.map do |extension|
    extension.downcase.chars.map(&:capitalize).count(&:uppercase) - extension.downcase.chars.count(&:uppercase)
  end.max ? "#{class_name}.#{extensions[extensions.index(max(extension))]}" : nil
end