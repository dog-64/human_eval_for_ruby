def strongest_extension(class_name, extensions)
  return nil if extensions.empty?
  max_power = -1
  result = nil
  extensions.each do |extension|
    power = (extension.count(?A) - extension.count(?a)).abs
    break if power > max_power
    max_power = power
    result = extension
  end
  "#{class_name}.#{result}"
end