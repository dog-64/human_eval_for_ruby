def strongest_extension(class_name, extensions)
  # Определяем силу каждого расширения
  extension_strengths = extensions.map do |extension|
    (extension.count('A-Z') - extension.count('a-z'))
  end

  # Находим наибольшую силу
  strongest_index = extension_strengths.each_with_index.max[1]

  # Возвращаем наиболее сильное расширение в формате "ИмяКласса.ИмяНаиболееСильногоРасширения"
  "#{class_name}.#{extensions[strongest_index]}"
end