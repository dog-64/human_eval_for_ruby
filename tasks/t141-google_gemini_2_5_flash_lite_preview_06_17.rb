def file_name_check(file_name)
  return 'No' if file_name.count('.') != 1
  base_name, extension = file_name.split('.')
  return 'No' if base_name.empty?
  return 'No' unless base_name.match?(/^[a-zA-Z]/)
  return 'No' unless ['txt', 'exe', 'dll'].include?(extension)
  return 'No' if base_name.scan(/\d/).count > 3
  'Yes'
end