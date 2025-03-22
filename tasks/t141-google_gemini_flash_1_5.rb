def file_name_check(file_name)
  parts = file_name.split('.')
  return 'No' if parts.length != 2
  name, ext = parts
  return 'No' if name.empty? || !name.match(/^[a-zA-Z][a-zA-Z0-9]{0,2}$/) || name.scan(/\d/).length > 3
  return 'No' unless ['txt', 'exe', 'dll'].include?(ext)
  'Yes'
end
