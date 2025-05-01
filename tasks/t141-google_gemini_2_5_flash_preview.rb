def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' unless parts.length == 2

  name_part = parts[0]
  extension_part = parts[1]

  return 'No' if name_part.empty?
  return 'No' unless name_part[0] =~ /[a-zA-Z]/

  digit_count = name_part.count('0-9')
  return 'No' if digit_count > 3

  valid_extensions = ['txt', 'exe', 'dll']
  return 'No' unless valid_extensions.include?(extension_part)

  'Yes'
end