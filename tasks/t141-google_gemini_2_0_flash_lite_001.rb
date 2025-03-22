def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' if parts.length != 2
  name, extension = parts
  return 'No' if name.empty?
  return 'No' unless name[0].match?(/[a-zA-Z]/)
  return 'No' unless ['txt', 'exe', 'dll'].include?(extension)
  digit_count = name.count('0-9')
  return 'No' if digit_count > 3
  'Yes'
end