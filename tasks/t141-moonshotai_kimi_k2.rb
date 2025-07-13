def file_name_check(file_name)
  return 'No' unless file_name.count('.') == 1
  
  name_part, extension = file_name.split('.')
  return 'No' if name_part.empty? || extension.empty?
  return 'No' unless name_part[0].match?(/[a-zA-Z]/)
  return 'No' unless ['txt', 'exe', 'dll'].include?(extension)
  
  digit_count = file_name.count('0-9')
  return 'No' if digit_count > 3
  
  'Yes'
end