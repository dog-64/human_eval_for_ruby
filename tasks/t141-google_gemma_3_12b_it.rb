def file_name_check(file_name)
  return 'No' unless file_name.include?('.')
  parts = file_name.split('.')
  return 'No' if parts.length != 2
  name, ext = parts
  return 'No' if name.empty?
  return 'No' unless name[0].match?(/[a-zA-Z]/)
  return 'No' if ext.nil? || ext.empty?
  valid_extensions = ['txt', 'exe', 'dll']
  return 'No' unless valid_extensions.include?(ext)
  digit_count = name.count('0'..'9')
  return 'No' if digit_count > 3
  return 'Yes'
end
