
def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' if parts.size != 2

  name, extension = parts
  return 'No' if name.empty? || extension.empty?
  return 'No' unless name[0] =~ /[a-zA-Z]/
  return 'No' unless ['txt', 'exe', 'dll'].include?(extension)
  return 'No' if name.count('0-9') > 3

  'Yes'
end