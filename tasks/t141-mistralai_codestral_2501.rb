def file_name_check(file_name)
  return 'No' if file_name.count('.') != 1
  name, ext = file_name.split('.')
  return 'No' if name.empty? || !name.match?(/\A[a-zA-Z]/)
  return 'No' unless ['txt', 'exe', 'dll'].include?(ext)
  return 'No' if name.count('0-9') > 3
  'Yes'
end