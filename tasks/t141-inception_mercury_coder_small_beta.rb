def file_name_check(file_name)
  valid_extensions = ['txt', 'exe', 'dll']
  name_parts = file_name.split('.')

  return 'No' unless name_parts.size == 2
  return 'No' unless name_parts[0].match?(/\A[a-zA-Z][a-zA-Z0-9]*\z/)
  return 'No' unless valid_extensions.include?(name_parts[1])
  return 'No' if name_parts[0].count('0-9') > 3

  'Yes'
end