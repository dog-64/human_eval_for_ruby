def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' unless parts.length == 2

  name = parts[0]
  ext = parts[1]

  return 'No' if name.empty?
  return 'No' unless name[0] =~ /[a-zA-Z]/

  return 'No' unless ['txt', 'exe', 'dll'].include?(ext)

  return 'No' if name.scan(/\d/).length > 3

  return 'Yes'
end