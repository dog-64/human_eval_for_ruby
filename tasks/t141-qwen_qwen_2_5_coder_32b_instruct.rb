def file_name_check(file_name)
  valid_extensions = ['txt', 'exe', 'dll']
  parts = file_name.split('.')

  return 'No' unless parts.size == 2
  return 'No' unless parts.first.match?(/\A[a-z]/i)
  return 'No' unless valid_extensions.include?(parts.last)
  return 'No' if parts.first.count('0-9') > 3

  'Yes'
end