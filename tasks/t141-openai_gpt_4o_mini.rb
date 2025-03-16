def file_name_check(file_name)
  return 'No' unless file_name =~ /^[a-zA-Z][\w.]*\.\w+$/
  name, ext = file_name.split('.')
  return 'No' unless ['txt', 'exe', 'dll'].include?(ext) && name.count('0-9') <= 3
  'Yes'
end